      SUBROUTINE Re_Construct
      USE Chem
      USE Global
      IMPLICIT NONE
      REAL*8 :: UL(12),UR(12)
      REAL*8 :: Tpt_,a
      INTEGER :: I,IP,NsI
      REAL*8,EXTERNAL :: E_to_T
      
C     All Conserved & Primitive Variables are Updated before Re-Construction
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

      DO I=0,N1p
          IP=I+1
             
          SELECT CASE(ReConstruct_TYPE)
              CASE(0)
C             不重构 （或者认为是零阶重构）
C                 格心左侧
                  UL(:)=Q1(:,I)
C                 格心右侧
                  UR(:)=Q1(:,I)
                    
              CASE(1)
C             3rd-MUSCL 
                  SELECT CASE(ReConstruct_PC)
                      CASE(1)
C                     Primitive Variables           
                          CALL MUSCL_3rd_P( I,UL(:),UR(:) )
                      CASE(2)
C                     Conserved Variables
                          CALL MUSCL_3rd_C( I,UL(:),UR(:) )

                  END SELECT

          END SELECT 

C=============================================================================================


          SELECT CASE( ReConstruct_PC )
              CASE(1)
C             Primitive Variables
C                 格心左侧
                  Rho(1,I)=UL(1)
                  U(1,I)=UL(2)
                  P(1,I)=UL(3)
C                 格心右侧
                  Rho(2,I)=UR(1)
                  U(2,I)=UR(2)
                  P(2,I)=UR(3)

C                 Mass Fraction
                  DO NsI=1,Ns1
                      Msf(1,NsI,I)=UL(3+NsI)   ! Cell Left Face
                      Msf(2,NsI,I)=UR(3+NsI)   ! Cell Right Face
                  END DO
C                 The Last Species is N2, which shall be determined by those of other species 
C                                                    to maintain mass conservation of species
                  Msf(1,Ns,I)=1 - SUM( Msf(1,1:Ns1,I) )
                  Msf(2,Ns,I)=1 - SUM( Msf(2,1:Ns1,I) )

              CASE(2)
C             2=Conserved Variables 
C             From Conserved Variables to Primitive Variables

C                 Mass Fraction
                  DO NsI=1,Ns1
                      Msf(1,NsI,I)=UL(3+NsI)/UL(1)
                      Msf(2,NsI,I)=UR(3+NsI)/UR(1)  
                  END DO
C                 The Last Species is N2, which shall be determined by those of other species 
C                                                    to maintain mass conservation of species
                  Msf(1,Ns,I)=1 - SUM( Msf(1,1:Ns1,I) )
                  Msf(2,Ns,I)=1 - SUM( Msf(2,1:Ns1,I) )


C                 *************************格心左侧*************************
                  Rho(1,I)=UL(1)
                  U(1,I)=UL(2)/UL(1)

C                 Get Temprature  || From 【 Total Specific Internal Energy 】 to Temperature
                  a = UL(3)/UL(1) - 0.5*U(1,I)**2 !!!!!!!!!!!!!!!!!!!!!Tiger!!!!!!!!!!!!!!!!!!!!!!
                  Tpt_ = Secant( X0, a, Msf(1,:,I), E_to_T, 1.E-3_8, 100 )

C                 Pressure  [ g/(cm*s^2) ]
                  CALL CKPY( Rho(1,I), Tpt_, Msf(1,:,I), IWORK, RWORK, P(1,I) ) 

 
C                 *************************格心右侧*************************
                  Rho(2,I)=UR(1)
                  U(2,I)=UR(2)/UR(1)

C                 Get Temprature  || From 【 Total Specific Internal Energy 】 to Temperature
                  a = UR(3)/UR(1) - 0.5*U(2,I)**2
                  Tpt_ = Secant( X0, a, Msf(2,:,I), E_to_T, 1.E-3_8, 100 )

C                 Pressure  [ g/(cm*s^2) ]
                  CALL CKPY( Rho(2,I), Tpt_, Msf(2,:,I), IWORK, RWORK, P(2,I) )


          END SELECT


      END DO

      END SUBROUTINE Re_Construct











