      SUBROUTINE Get_All_Viscous_Flux
      USE Global
      IMPLICIT NONE
      INTEGER :: I,IM,NsI
      REAL*8 :: Msf_L(Ns),Msf_R(Ns)
      REAL*8 :: Mu_,Cc_,D_,U_,H_,R_
C     To calculate Viscous numerical flux at cell interface
C     The required Variables are primitive variables : rho, u, p, Y1...
C     Transport Coefficients are acquired from CHEMIKIN
C     All Variables at Cell Interface are obtained by Second-Order Central Schemes
C     Temperatures have been obtained through Update.for 

C     X_= 0.5*(Xl+Xr)
C     ¡¾ Mu ¡¿ The Viscousity at cell center of the Gas Mixture need to be calculated ahead, using CHEMIKIN
C     ¡¾ Cc ¡¿ The Thermal Conductivity at cell center of the Gas Mixture need to be calculated ahead, using CHEMIKIN
C     ¡¾ Dfc¡¿ The Diffusivity at cell center of each species need to be calculated ahead, using CHEMIKIN
C     They need to be obtained through Transport_Coefs.for
C     The Enthalpies at cell center of each species have been obained through Update.for

          DO I=1,N1p

              IM=I-1

              Mu_=0.5*( Mu(I) + Mu(IM) )
              U_=0.5*( Q1(2,I)+Q1(2,IM) )
              Cc_=0.5*( Cc(I)+Cc(IM) )
              R_=0.5*( Q1(1,I)+Q1(1,IM) )

              Gv(1,I)=0.0_8
              Gv(2,I)=4.0/3.0*Mu_*( Q1(2,I)-Q1(2,IM) )/dh              ! 4/3*¦Ì*du/dx
              Gv(3,I)=4.0/3.0*Mu_*U_*( Q1(2,I)-Q1(2,IM) )/dh           ! 4/3*¦Ì*u*du/dx 
     >                  + Cc_*( Tpt(I)- Tpt(IM) )/dh                   ! ¦Ë*dT/dx
              DO NsI=1,Ns
                  H_=0.5*( H(NsI,I)+H(NsI,IM) )
                  D_=0.5*( Dfc(NsI,I)+Dfc(NsI,IM) )
                  Gv(3,I)=Gv(3,I) + R_*H_*D_*( Q1(3+NsI,I) - Q1(3+NsI,IM) )/dh     !   rho*hi*Di*dYi/dx

                  Gv(3+NsI,I)= R_*D_*( Q1(3+NsI,I) - Q1(3+NsI,IM) )/dh             !   rho*Di*dYi/dx

              END DO

          END DO
      
      END SUBROUTINE Get_All_Viscous_Flux    