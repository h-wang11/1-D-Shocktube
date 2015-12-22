      SUBROUTINE Get_All_Convective_Flux
      USE Global
      IMPLICIT NONE
      INTEGER :: I,IM,IP
      REAL*8  :: Rl,Rr,Ul,Ur,Pl,Pr
      REAL*8  :: Msf_L(Ns),Msf_R(Ns)
C     To calculate Convective numerical flux at cell interface
C     The required Variables are primitive variables : rho, u, p, Y1...
C     Temperature can be obtained from Equation of State, using rho & p & Y1...

          DO I=1,N1p

              IM=I-1
              IP=I+1

                    Rl =   Rho(2,IM)
                    Ul =     U(2,IM)
                    Pl =     P(2,IM)
              Msf_L(:) = Msf(2,:,IM)

                    Rr =   Rho(1,I)
                    Ur =     U(1,I)
                    Pr =     P(1,I)
              Msf_R(:) = Msf(1,:,I)

              CALL Get_AUSMPW_Plus_Flux(Rl,Rr,Ul,Ur,Pl,Pr,Msf_L,Msf_R,  G(:,I) )

          END DO
      
      END SUBROUTINE Get_All_Convective_Flux    