      MODULE Global
      IMPLICIT NONE
      
      INTEGER :: Iter
      INTEGER :: N                            ! Mesh Nodes
      INTEGER :: N1p,N2p,N3p,N1m,N2m,N3m      ! N1p=N+1,N1m=N-1  
      INTEGER :: ReConstruct_TYPE             ! Type of Re-Consturction  
      INTEGER :: ReConstruct_PC               ! Re-Constructed Variables [ Primitive / Conserved ]
            
      REAL*8,ALLOCATABLE :: Q1(:,:)                           ! 原始变量 [ (rho,u,p,Y1...); I ]
      REAL*8,ALLOCATABLE :: Tpt(:)                            ! 原始变量 => Temperature
      REAL*8,ALLOCATABLE :: F(:,:),F0(:,:),F1(:,:)            ! 守恒变量 [ (rho,rho*u,rho*et,rho*Y1...); I ]： F 为中间时刻, F0 为 N-1时刻, F1 为 N 时刻
      REAL*8,ALLOCATABLE :: F2(:,:)                           ! 守恒变量                                    ： 3rd-Explicit_TVD_Runge-Kutta 时间推进中间变量
      REAL*8,ALLOCATABLE :: Gc(:,:)                           ! Convective Flux [ Structure = Q1/F ]
      REAL*8,ALLOCATABLE :: Gv(:,:)                           ! Viscous    Flux
      REAL*8,ALLOCATABLE :: Gs(:,:)                           ! Source     Term
      REAL*8,ALLOCATABLE :: X(:)                              ! Mesh Coordinates
      REAL*8,ALLOCATABLE :: Rho(:,:),U(:,:),P(:,:),Msf(:,:,:) ! 重构的左右状态： 密度, 速度, 压力, 组份质量分数( Mass Fraction )
      REAL*8,ALLOCATABLE :: Mlw(:)                            ! Molecular Weight of Each Species [ g/mol ]
      REAL*8,ALLOCATABLE :: Dfc(:,:)                          ! Diffusion Coefficient    [ ( Ns, I ) ]
      REAL*8,ALLOCATABLE :: Mu(:)                             ! Viscosity of Mixture [ ( I ) ]
      REAL*8,ALLOCATABLE :: Cc(:)                             ! Conductivity Coefficient of Mixture [ ( I ) ]

C     Other Necessary Variables ?... Remain to be added..
C     ...
      INTEGER :: Ns                           ! Number of Species
      INTEGER :: NT                           ! Number of total conserved variables ! NT = Ns + 3



      REAL*8 :: dt                                           ! 统一时间步长
      REAL*8 :: dh                                           ! 均匀网格尺寸
      REAL*8 :: Length                                       ! 计算域总长度
      REAL*8 :: Time                                         ! 当前计算时刻
      REAL*8 :: ETime                                        ! 计算终止时刻
      CHARACTER(8) :: NN                                     ! 输出格点数
      
      REAL*8,PARAMETER :: Tpt0=298.15                        ! Reference Temperature   [ K ]
      REAL*8,PARAMETER :: Pi=3.1415926535898_8               ! Pi
      REAL*8,PARAMETER :: R0=8.31441                         ! Universal Gas Constant [ J/(mol*K) ]
      REAL*8,PARAMETER :: Tiny=1.0E-20_8                     ! 避免分母为零
           
      
      END MODULE Global


C=========================================================================

      SUBROUTINE Get_Tpt(R,P,Y, T)
      USE Global, ONLY: Ns,Mlw,R0
      IMPLICIT NONE
      REAL*8 :: YR,Y(Ns)
      INTEGER :: I
C     Get Temperature from Equation of State
C         R = Density
C         P = Pressure
C         Y = Mass Fraction
C         T = Temeprature 
C        Mlw= Molecular Weight of each species
C         R0= Universal Gas Constant [ J/(mol*K) ]

          YR=0.0_8
                  
          DO I=1,Ns
              YR=YR + Y(I)/Mlw(I) 
          END DO

          T=P/R/( YR*R0*1.0E3_8 )  ! 1.0E3_8 => from g to kg 

      END SUBROUTINE Get_Tpt
C---------------------------------------------------------------

      SUBROUTINE Get_P(R,Y,T, P)
      USE Global, ONLY: Ns,Mlw,R0
      IMPLICIT NONE
      REAL*8 :: YR,Y(Ns)
      INTEGER :: I
C     Get Pressure from Equation of State
C         R = Density
C         P = Pressure
C         Y = Mass Fraction
C         T = Temeprature 
C        Mlw= Molecular Weight of each species
C         R0= Universal Gas Constant [ J/(mol*K) ]

          YR=0.0_8
                  
          DO I=1,Ns
              YR=YR + Y(I)/Mlw(I) 
          END DO

          P=R*T*( YR*R0*1.0E3_8 ) ! 1.0E3_8 => from g to kg 

      END SUBROUTINE Get_P