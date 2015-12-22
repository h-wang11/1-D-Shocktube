      SUBROUTINE Initial
      USE Global
      IMPLICIT NONE
      INTEGER :: I,NsI
      CHARACTER(100) :: FNAME

           
C     Flow Field Initial Values
          DO I=-2,N3p

              IF ( X(I).LT.0.0 ) THEN
C             Left States

C                 Density, Velocity, Pressure
                  Q1(1,I)=1.0_8               ! rho
                  Q1(2,I)=0.75_8              ! u
                  Q1(3,I)=1.0_8               ! p

C                 Mass Fraction of Each Species
                  Q1(4,I)=0.1
C                 ...
                  Q1(12,I)=0.1

C                 Temperature
                  CALL Get_Tpt( Q1(1,I), Q1(3,I), Q1(4:NT), Tpt(I) )

              ELSE
C             Right States

C                 Density, Velocity, Pressure
                  Q1(1,I)=0.125_8
                  Q1(2,I)=0.0_8
                  Q1(3,I)=0.1_8 

C                 Mass Fraction of Each Species
                  Q1(4,I)=0.1
C                 ...
                  Q1(12,I)=0.1

C                 Temperature
                  CALL Get_Tpt( Q1(1,I), Q1(3,I), Q1(4:NT), Tpt(I) )

              END IF

C             Conserved Variables

              F1(1,I)=Q1(1,I)                                                       ! rho
              F1(2,I)=Q1(1,I)*Q1(2,I)                                               ! rho*u

              !F1(3,I)=1.0_8/(Gamma-1.0_8)*Q1(3,I) + 0.5_8*Q1(1,I)*( Q1(2,I)**2 )    ! rho*et
C             To Calculate Internal Energy, Enthalpy of Each Species is needed
C                 rho*et = rho*e + 0.5*rho*u^2
C                        = rho*h + 0.5*rho*u^2 - p
C                        = SUM(rho*Yi*hi)_i + 0.5*rho*u^2 - p

              DO NsI=1,Ns
                  F1( 3 + NsI, I)=Q1(1,I)*Q1( 3 + NsI, I)                           ! Mass Concentration
              END DO
                      
          END DO

C         Initialization of Time Advance
          F0=F1
           F=F1
          F2=F1

      END SUBROUTINE