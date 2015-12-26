      SUBROUTINE Update_RK
      USE Chem
      USE Global
      IMPLICIT NONE
      INTEGER :: I,NsI
      REAL*8 :: a
      REAL*8,EXTERNAL :: E_to_T
C     Update Variables for 3rd-Explicit_TVD Runge-Kutta 
C     割线法函数接口
      INTERFACE 
          FUNCTION Secant( X0, a, Msf, F, Epsilon, MAX_Iter )
              USE Chem
              USE Global, ONLY: Ns
              IMPLICIT NONE
              REAL*8 :: Secant  
              REAL*8 :: a             
              REAL*8 :: Msf(Ns)                
              REAL*8 :: X0(2)          
              REAL*8 :: Epsilon    
              INTEGER :: MAX_Iter     
              REAL*8,EXTERNAL :: F       
          END FUNCTION Secant
      END INTERFACE
          
          F2=F0  ! F2 只在第三步 RK 迭代中使用, 代表 n 时刻变量
C                                                                 第一步 RK 迭代后为上一步时间迭代的二级中间变量
C                                                                 第二步 RK 迭代后 F2 为 n 时刻变量
C                                                                 第三步 RK 迭代后为一级中间变量

          F0=F1  ! F0 始终是比最新时刻变量早一时刻的变量 （ 只在第二步 RK 迭代中使用）
C                                                         第一步 RK 迭代后是 n 时刻变量
C                                                         第二步 RK 迭代后是 一级中间变量
C                                                         第三步 RK 迭代后是 二级中间变量
          F1=F   ! F始终是中间变量
C                                  在第一步 RK 迭代后为一级中间变量
C                                  在第二步 RK 迭代后为二级中间变量
C                                  在第三步 RK 迭代后是 n+1 时刻变量


          DO I=1,N
C         From Conserved Variables to Primitive Variables

              Q1(1,I)=F1(1,I)                                                    ! rho   || F1 = rho
              Q1(2,I)=F1(2,I)/Q1(1,I)                                            ! u     || F2 = rho*u  || F3= rho*et

C             Mass Fraction
              DO NsI=1,Ns1
                  Q1(3+NsI,I)=F1(3+NsI,I)/Q1(1,I) 
              END DO
C             The Last Species is N2, which shall be determined by those of other species 
C                                                to maintain mass conservation of species
              Q1(NT,I)=1 - SUM( Q1(4:NT1,I) )

C             Get Temprature  || From 【 Total Specific Internal Energy 】 to Temperature
              a = F1(3,I)/F1(1,I) - 0.5*Q1(2,I)**2
              Tpt(I) = Secant( X0, a, Q1(4:NT,I), E_to_T, TOL_, 1000 )

C                 ht= SUM(Yi*hi) + 0.5*u^2 = et + R*T        ! R = Mean Gas Constant of the Mixture
C                 => F1(3,I)/F1(1,I) + R*T - [ SUM(Yi*hi) + 0.5*u^2 ] =0  || By Newton-Raphson( Secant Method ) Iterations
C                                                                         || F1(3,I), F1(1,I), R, Yi,u are KNOWN
C                                                                         || hi, T is UNKNOWN, and T is output

C             Pressure  [ g/(cm*s^2) ]
              CALL CKPY( Q1(1,I), Tpt(I), Q1(4:NT,I), IWORK, RWORK, Q1(3,I) )

C             Enthalpies at 【cell center】 of each species, use by Mass Diffusion terms
C             Units [ ergs/g ]
              CALL CKHMS( Tpt(I), IWORK, RWORK, H(:,I) )

          END DO
          
      END SUBROUTINE Update_RK








C=====================================Secant Method=====================================
      FUNCTION Secant( X0, a, Msf, F, Epsilon, MAX_Iter )
      USE Chem
      USE Global, ONLY: Ns
      IMPLICIT NONE
      REAL*8 :: Secant            ! 迭代找到的零点
      REAL*8 :: a                 ! 输入参数（迭代式中的常数项）
      REAL*8 :: Msf(Ns)           ! Mass Fractions
      REAL*8 :: F1,F2             ! 迭代时的函数值 ( F1 表示上一迭代步, F2 表示当前迭代步 )
      REAL*8 :: X1,X2             ! 迭代时的自变量 ( X1 表示上一迭代步, X2 表示当前迭代步 )
      REAL*8 :: X0(2)             ! X0 表示猜测的初始范围
      REAL*8 :: Epsilon, DF       ! 收敛判据

      INTEGER :: MAX_Iter,I       ! 最大迭代步数

      REAL*8,EXTERNAL :: F        ! 迭代函数

C     NOTE:
C             初始的两个值所确定的自变量区间，“一定要包含零点” ！！！

C     首先确定初始函数值
          X1=X0(1)
          X2=X0(2)
      
          F1=F( a, Msf, X1 )
          F2=F( a, Msf, X2 )

          DO I=1,MAX_Iter
          
              DF=ABS(F1-F2)
              !WRITE(1000,*)DF,X1
              IF ( DF.LT.Epsilon ) THEN
                  EXIT
              END IF

              Secant = X1 - F1*( X1-X2 )/( F1-F2 )

              F2=F1                       ! 更新函数值

              X2=X1                       ! 跟新自变量
              X1=Secant           

              F1=F( a, Msf, Secant )      ! 确定当前迭代步F1



          END DO

          IF ( DF.GT.Epsilon ) THEN
              WRITE(*,*) 'No solution...'
              PAUSE
              STOP
          END IF

      END FUNCTION Secant


C========================================Function E_to_T========================================
      FUNCTION E_to_T( a, Msf, T )
      USE Chem
      USE Global, ONLY: Ns,Mlw,R0
      IMPLICIT NONE
      REAL*8 :: E_to_T
C     F1(3,I)/F1(1,I) + R*T - [ SUM(Yi*hi) + 0.5*u^2 ] =0   !  R= R0/W_ || W_= 1 / SUM( Msf(I)/Mlw(I) )
C     
C                                                         <=>  a + R*T - SUM(Yi*hi) =0  || a = F1(3,I)/F1(1,I) - 0.5*u^2 
      REAL*8 :: a,T
      REAL*8 :: Msf(Ns)
      REAL*8 :: WTM,R,HBMS

      CALL Get_WTM( Msf, Mlw, WTM )                 ! 1_HLLEM.for\Get_WTM   | Mean molecular weight of the gas mixture
      R=R0/WTM 
      CALL CKHBMS( T, Msf, IWORK, RWORK, HBMS )     ! HBMS = Mean Specific Enthalpy of the Gas Mixture [ ergs/g ]

      E_to_T = a + R*T - HBMS

      END FUNCTION E_to_T
C===============================================================================================
                                         
C========================================Function H_to_T========================================
      FUNCTION H_to_T( a, Msf, T )
      USE Chem
      USE Global, ONLY: Ns
      IMPLICIT NONE
      REAL*8 :: H_to_T
C     Hs - SUM( Yi_s*hi(Ts) ) - 0.5*Us^2 =0   <=>  a - SUM(Yi*hi) =0  || a = Hs - 0.5*Us^2
     
      REAL*8 :: a,T
      REAL*8 :: Msf(Ns)
      REAL*8 :: HBMS

      CALL CKHBMS( T, Msf, IWORK, RWORK, HBMS )     ! HBMS = Mean Specific Enthalpy of the Gas Mixture [ ergs/g ]

      H_to_T = a - HBMS

      END FUNCTION H_to_T
C===============================================================================================
