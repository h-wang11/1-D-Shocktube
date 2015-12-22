      SUBROUTINE All_Flux(Method0,A)
      USE Global, ONLY: Gamma,Rho,U,P,G
      IMPLICIT NONE
      INTEGER :: Method0,A,AM,AP
      REAL*8 :: G1,G2,G3,Rl,Rr,Ul,Ur,Pl,Pr,Hl,Hr,El,Er,Sl,Sr
      
      AM=A-1
      AP=A+1

          Rl=Rho(2,AM)
          Ul=  U(2,AM)
          Pl=  P(2,AM)
          Rr=Rho(1,A)
          Ur=  U(1,A)
          Pr=  P(1,A)
      
      SELECT CASE(Method0)
          CASE(12)
C         Roe Flux

              Hl=Gamma/(Gamma-1.0_8)*Pl/Rl + 0.5*( Ul**2 )
              Hr=Gamma/(Gamma-1.0_8)*Pr/Rr + 0.5*( Ur**2 )
              
              CALL Get_Roe_Flux(Rl,Rr,Ul,Ur,Pl,Pr,G1,G2,G3)
              G(1,A)=0.5*(Rr*Ur+Rl*Ul) - 0.5*G1
              G(2,A)=0.5*(Rr*Ur**2+Rl*Ul**2+Pr+Pl) - 0.5*G2
              G(3,A)=0.5*(Rr*Ur*Hr+Rl*Ul*Hl) - 0.5*G3
              
          CASE(11)
C         Godunov Flux

              CALL Get_Godunov_Flux(Rl,Rr,Ul,Ur,Pl,Pr,G1,G2,G3)
              G(1,A)=G1
              G(2,A)=G2
              G(3,A)=G3

          CASE(21)
C         Steger-Warming_FVS Flux

              CALL Get_SW_FVS_Flux( 1,Rl,Ul,Pl,G1,G2,G3)
                  G(1,A)=G1
                  G(2,A)=G2
                  G(3,A)=G3
              CALL Get_SW_FVS_Flux(-1,Rr,Ur,Pr,G1,G2,G3)
                  G(1,A)=G(1,A)+G1
                  G(2,A)=G(2,A)+G2
                  G(3,A)=G(3,A)+G3

          CASE(22)
C         Smooth Splitting of Characteristic Speed for Steger-Warming_FVS Flux
              CALL Get_SSW_FVS_Flux( 1,Rl,Ul,Pl,G1,G2,G3)
                  G(1,A)=G1
                  G(2,A)=G2
                  G(3,A)=G3
              CALL Get_SSW_FVS_Flux(-1,Rr,Ur,Pr,G1,G2,G3)
                  G(1,A)=G(1,A)+G1
                  G(2,A)=G(2,A)+G2
                  G(3,A)=G(3,A)+G3

          CASE(23)
C         Van Leer_FVS Flux
              CALL Get_VL_FVS_Flux( 1,Rl,Ul,Pl,G1,G2,G3)
                  G(1,A)=G1
                  G(2,A)=G2
                  G(3,A)=G3
              CALL Get_VL_FVS_Flux(-1,Rr,Ur,Pr,G1,G2,G3)
                  G(1,A)=G(1,A)+G1
                  G(2,A)=G(2,A)+G2
                  G(3,A)=G(3,A)+G3
          CASE(24)
C         Van Leer_FVS Flux modified by Hanel, inspiring further modifications by Van Leer

          CASE(31)
C         Original AUSM

              CALL Get_AUSM_Flux(Rl,Rr,Ul,Ur,Pl,Pr,G1,G2,G3)
              G(1,A)=G1
              G(2,A)=G2
              G(3,A)=G3

          CASE(41,42,43)
C         HLL-( R,E,EM ) Flux

              CALL Get_HLL_Flux(Rl,Rr,Ul,Ur,Pl,Pr,G1,G2,G3)
              G(1,A)=G1
              G(2,A)=G2
              G(3,A)=G3
              
      END SELECT
      
      END SUBROUTINE  All_Flux

      SUBROUTINE Get_All_Flux(Method0)
      USE Global
      IMPLICIT NONE
      
      INTEGER :: Method0
      INTEGER :: I
          DO I=1,N1p
              CALL All_Flux(Method0,I)
          END DO
      
      END SUBROUTINE Get_All_Flux     