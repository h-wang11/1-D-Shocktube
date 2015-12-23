      SUBROUTINE Initial
      USE Chem
      USE Global
      IMPLICIT NONE
      INTEGER :: I,NsI
      REAL*8 :: HBMS
C     Mean Specific Enthalpy of the Gas Mixture [ ergs/g ]
      CHARACTER(100) :: FNAME

           
C     Flow Field Initial Values
          DO I=-2,N3p

              IF ( X(I).LT.0.0 ) THEN
C             Left States

C                 Density, Velocity, Pressure
                  Q1(1,I)=1.E-3_8             ! rho  [ g/cm^3 ]
                  Q1(2,I)=0.0_8               ! u    [ cm/s ]
                  Tpt(I)=800_8                ! Temperature [ K ]     

C                 Mass Fraction of Each Species
C                 Species Sequence => H2, O2, O, OH, H2O, H, HO2, H2O2, N2
C                                      4   5  6   7    8  9   10    11  12
                  Q1(4:NT,I)=0.0_8
                  Q1(4,I)=0.0_8             ! H2
                  Q1(5,I)=0.27_8            ! O2
                  Q1(12,I)=0.73_8           ! N2

C                 Pressure  [ g/(cm*s^2) ]
                  CALL CKPY( Q1(1,I), Tpt(I), Q1(4:NT,I), IWORK, RWORK, Q1(3,I) )   

              ELSE
C             Right States

C                 Density, Velocity, Pressure
                  Q1(1,I)=5.E-4_8
                  Q1(2,I)=0.0_8
                  Tpt(I)=600_8                

C                 Mass Fraction of Each Species
C                 Species Sequence => H2, O2, O, OH, H2O, H, HO2, H2O2, N2
                  Q1(4:NT,I)=0.0_8
                  Q1(4,I)=0.1_8            ! H2
                  Q1(5,I)=0.2_8            ! O2
                  Q1(12,I)=0.7_8           ! N2

C                 Pressure  [ g/(cm*s^2) ]
                  CALL CKPY( Q1(1,I), Tpt(I), Q1(4:NT,I), IWORK, RWORK, Q1(3,I) )

              END IF

C             Conserved Variables

              F1(1,I)=Q1(1,I)                                                       ! rho
              F1(2,I)=Q1(1,I)*Q1(2,I)                                               ! rho*u

              CALL CKHBMS( Tpt(I), Q1(4:NT,I), IWORK, RWORK, HBMS )
              F1(3,I)= Q1(1,I)*HBMS + 0.5*Q1(1,I)*Q1(2,I)**2 - Q1(3,I)              ! rho*et 
C             To Calculate Internal Energy, Enthalpy of Each Species is needed
C                 rho*et = rho*e + 0.5*rho*u^2
C                        = rho*h + 0.5*rho*u^2 - p
C                        = SUM(rho*Yi*hi)_i + 0.5*rho*u^2 - p
C                        = rho*HBMS + 0.5*rho*u^2 - p
C                   HBMS = Mean Specific Enthalpy of the Gas Mixture [ ergs/g ]

              DO NsI=1,Ns
                  F1( 3 + NsI, I)=Q1(1,I)*Q1( 3 + NsI, I)                           ! Mass Concentration
              END DO
                      
          END DO

C         Initialization of Time Advance
          F0=F1
           F=F1
          F2=F1

      END SUBROUTINE