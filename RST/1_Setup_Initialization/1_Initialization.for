      SUBROUTINE Initial
      USE Chem
      USE Global
      IMPLICIT NONE
      INTEGER :: I,NsI
      REAL*8 :: HBMS,Mlf(Ns)
      REAL*8 :: Tpt_,a,WTM,R
C     Mean Specific Enthalpy of the Gas Mixture [ ergs/g ]
      CHARACTER(100) :: FNAME
      REAL*8,EXTERNAL :: E_to_T
      

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
           
C     Flow Field Initial Values

      SELECT CASE( IF_Continue )
          CASE(0)
C         不续算,重头开始
              DO I=-2,N3p

                  IF ( X(I).LT.0.0 ) THEN
C                 Left States

C                     Velocity, Pressure, Temperature 
                      Q1(2,I)=0.0_8                ! u    [ cm/s ]
                      Q1(3,I)=0.5_8*atm            ! p    [ g/(cm*s^2) ]= [ 1E-3kg/(1E-2m)*s^2 ] = [ 0.1 Pa ]
                      Tpt(I)=1500.0_8              ! Temperature [ K ]     

C                     Mass Fraction of Each Species
C                     Species Sequence  => H2,  O2,  O,  OH,  H2O,  H,  HO2,  H2O2,  N2
C                                 Q1(:,I)   4    5   6    7    8    9    10     11   12
C                                  Mlf(:)   1    2   3    4    5    6     7      8    9
                      Mlf(:) = 0.0_8
                      Mlf(1) = 0.2_8              ! H2
                      Mlf(2) = 0.1_8              ! O2
                      Mlf(9) = 0.7_8              ! N2

                      CALL CKXTY( Mlf, IWORK, RWORK, Q1(4:NT,I) )                     ! Mole Fraction to Mass Fraction
                      CALL CKRHOX( Q1(3,I), Tpt(I), Mlf, IWORK, RWORK, Q1(1,I) )      ! Pressure, Temperature, Mole Fractions => Mass Density

                  ELSE
C                 Right States

C                     Velocity, Pressure, Temperature 
                      Q1(2,I)=0.0_8                ! u    [ cm/s ]
                      Q1(3,I)=0.1_8*atm            ! p    [ g/(cm*s^2) ]= [ 1E-3kg/(1E-2m)*s^2 ] = [ 0.1 Pa ]
                      Tpt(I)=1500.0_8              ! Temperature [ K ]                

C                     Mass Fraction of Each Species
C                     Species Sequence  => H2,  O2,  O,  OH,  H2O,  H,  HO2,  H2O2,  N2
C                                 Q1(:,I)   4    5   6    7    8    9    10     11   12
C                                  Mlf(:)   1    2   3    4    5    6     7      8    9
                      Mlf(:) = 0.0_8
                      Mlf(1) = 0.2_8              ! H2
                      Mlf(2) = 0.1_8              ! O2
                      Mlf(9) = 0.7_8              ! N2

                      CALL CKXTY( Mlf, IWORK, RWORK, Q1(4:NT,I) )                     ! Mole Fraction to Mass Fraction
                      CALL CKRHOX( Q1(3,I), Tpt(I), Mlf, IWORK, RWORK, Q1(1,I) )      ! Pressure, Temperature, Mole Fractions => Mass Density

                  END IF

C                 Conserved Variables

                  F1(1,I)=Q1(1,I)                                                       ! rho
                  F1(2,I)=Q1(1,I)*Q1(2,I)                                               ! rho*u

                  CALL CKHBMS( Tpt(I), Q1(4:NT,I), IWORK, RWORK, HBMS )
                  F1(3,I)= Q1(1,I)*HBMS + 0.5*Q1(1,I)*Q1(2,I)**2 - Q1(3,I)              ! rho*et 
C                 To Calculate Internal Energy, Enthalpy of Each Species is needed
C                       rho*et = rho*e + 0.5*rho*u^2
C                              = rho*h + 0.5*rho*u^2 - p
C                              = SUM(rho*Yi*hi)_i + 0.5*rho*u^2 - p
C                              = rho*HBMS + 0.5*rho*u^2 - p
C                         HBMS = Mean Specific Enthalpy of the Gas Mixture [ ergs/g ]

                  DO NsI=1,Ns
                      F1( 3 + NsI, I)=Q1(1,I)*Q1( 3 + NsI, I)                           ! Mass Concentration
                  END DO
                     
              END DO
          CASE(1)
C         续算
C             需要： Q1,F1,Tpt,Time
              OPEN(101,FILE='BackUp.dat',ACTION='READ',FORM='UNFORMATTED')

                  READ(101)Time,Iter
                  READ(101)( Q1(:,I),I=-2,N3p )
                  READ(101)( F1(:,I),I=-2,N3p )
                  READ(101)( Tpt( I),I=-2,N3p )
              CLOSE(101)

      END SELECT

C         Initialization of Time Advance
          F0=F1
           F=F1
          F2=F1

      END SUBROUTINE