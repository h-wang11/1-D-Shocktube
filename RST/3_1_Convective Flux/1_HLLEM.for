      SUBROUTINE Get_HLLEM_Flux(Rl,Rr,Ul,Ur,Pl,Pr,Msf_L,Msf_R, G_)   ! Only G_ is Output
      USE Chem
      USE Global, ONLY: Ns,Ns1,NT,R0,Mlw,X0,TOL_
      IMPLICIT NONE
C     HLLEM for convective numerical flux
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

      INTEGER :: NsI
      REAL*8 :: R_l,R_r,WTM,Cpl,Cpr,Gamma_l,Gamma_r
C     R_l/r = Mean Gas Constant of the Mixture
C     WTM = Mean molecular weight of the gas mixture
C     Cpl/r = Mean Specific Heat of the gas mixture at constant pressure
C     Gamma_l/r= Specific Ratio of Gas Mixture 
      REAL*8 :: Rl,Rr,Ul,Ur,Pl,Pr,Hl,Hr,El,Er,Tl,Tr         
      REAL*8 :: L,R
      REAL*8 :: Rs,Us,Hs,Es,Ss,Gamma_s,R_s,Ts,Cps
C     Rs = Density
C     Us = Velocity
C     Hs = Total Specific Enthalpy
C     Es = Total Specific Internal Energy
C     Ss = Sonic Speed
C     Gamma_s = Specific Heat Ratio
C     R_s = Mean Gas Constant
      REAL*8 :: Msf_L(Ns),Msf_R(Ns),G_(NT),CPMS(Ns),Msf_s(Ns)
      REAL*8 :: Sl,Sr                                 
      REAL*8 :: al,ar
      REAL*8 :: a,HBMS
      REAL*8,EXTERNAL :: H_to_T

      Rl=ABS(Rl)
      Rr=ABS(Rr)

      CALL Get_WTM( Msf_L, Mlw, WTM )                     ! Mean molecular weight of the gas mixture given mass fractions
      R_l=R0/WTM                                          ! Mean Gas Constant of the Mixture
      Tl=Pl/(Rl*R_l)                                      ! Temperature of Left Side
      CALL CKHBMS( Tl, Msf_L, IWORK, RWORK, HBMS )        ! Mean Specific Enthalpy of the Gas Mixture [ ergs/g ]
      Hl = HBMS + 0.5*Ul**2
      El = Hl - Pl/Rl 
C             To Calculate Internal Energy, Enthalpy of Each Species is needed
C                 rho*et = rho*e + 0.5*rho*u^2
C                        = rho*h + 0.5*rho*u^2 - p
C                        = SUM(rho*Yi*hi)_i + 0.5*rho*u^2 - p
C                        = rho*HBMS + 0.5*rho*u^2 - p

      CALL Get_WTM( Msf_R, Mlw, WTM )      
      R_r=R0/WTM                                      
      Tr=Pr/(Rr*R_r)                                
      CALL CKHBMS( Tr, Msf_R, IWORK, RWORK, HBMS ) 
      Hr = HBMS + 0.5*Ur**2
      Er = Hr - Pr/Rr 


C     Roe Average States
      L=SQRT(Rl)/( SQRT(Rl)+SQRT(Rr) )
      R=SQRT(Rr)/( SQRT(Rl)+SQRT(Rr) )
      Rs=SQRT(Rl*Rr)
      Us=Ul*L+Ur*R
      Hs=Hl*L+Hr*R
      Es=El*L+Er*R
      Msf_s= Msf_L*L + Msf_R*R

C     Sonic Speed 
C     Need to Calculate Gamma, which requires Cps of each species
C                                 Gamma=Cp/(Cp-R), Cp = SUM(Yi*Cpi) , R= SUM(Yi*Ri), Ri=R0/Wi
C                                                  Cpi= Cpi(T)
      CALL CKCPMS (Tl, IWORK, RWORK, CPMS)  ! Returns the specific heats at constant pressure in mass units || [ ergs/(g*K) ]
      Cpl= DOT_PRODUCT( Msf_L, CPMS )
      Gamma_l= Cpl/( Cpl-R_l )
      Sl=SQRT(Gamma_l*Pl/Rl)

      CALL CKCPMS (Tr, IWORK, RWORK, CPMS)  ! Returns the specific heats at constant pressure in mass units || [ ergs/(g*K) ]
      Cpr= DOT_PRODUCT( Msf_R, CPMS )
      Gamma_r= Cpr/( Cpr-R_r )
      Sr=SQRT(Gamma_r*Pr/Rr)


C     【 Estimation of Wave Speed 】

C     There are TWO different ways of calculating Average Sonic Speed
C     First,  Need to Calculate Average Temperature from Total Enthalpy and Only Once
C                     Hs=H_Roe-Average => Ts => Gamma_s => Ss=SQRT(Gamma_s*R*Ts)
C     Second, Need to Calculate Temperatures of Both L&R side from Total Enthalpy, and Twice
C                     Ts=T_Roe-Average =>       Gamma_s => Ss=SQRT(Gamma_s*R*Ts) 
C     Remain to be Compared, further investigation
C     Suggestion: USE the FIRST method  !!! NO!~ NO!~ NO!~
C     It's shown that from Hs to Ts ,the Secant Method can't converge sometimes
C     This is Because Hs,Msf_s are usually non-physical                                           

C     Average Sonic Speed
C*****************************************************Bad*****************************************************
!C     Hs - SUM( Yi_s*hi(Ts) ) - 0.5*Us^2 =0
!C                                             <=>  a       - SUM(Yi*hi) =0  || a = Hs - 0.5*Us^2
!C             Get Temprature  || From 【 Total Specific Enthalpy 】 to Temperature
!              a = Hs - 0.5*Us**2
!              Ts = Secant( X0, a, Msf_s, H_to_T, TOL_, 1000 )
!
!      CALL Get_WTM( Msf_s, Mlw, WTM )                    
!      R_s=R0/WTM       
!      CALL CKCPMS (Ts, IWORK, RWORK, CPMS)  ! Returns the specific heats at constant pressure in mass units || [ ergs/(g*K) ]
!      Cps= DOT_PRODUCT( Msf_s, CPMS )
!      Gamma_s= Cps/( Cps-R_s )                                
!      Ss= SQRT( Gamma_s*R_s*Ts )
C*************************************************************************************************************
      Ss=L*Sl+R*Sr

      al=Ul - Sl
      ar=Ur + Sr

      Sr = MAX(ar,Us+Ss)
      Sl = MIN(al,Us-Ss)

C     HLL Numerical Flux

      IF ( Sl.GE.0 ) THEN
          G_(1)= Rl*Ul
          G_(2)= Rl*Ul**2+Pl
          G_(3)= Rl*Ul*Hl
          DO NsI=1,Ns
              G_(3+NsI)= Rl*Ul*Msf_L(NsI)
          END DO
                  
      ELSE IF ( Sr.LE.0 ) THEN
          G_(1)= Rr*Ur
          G_(2)= Rr*Ur**2+Pr
          G_(3)= Rr*Ur*Hr
          DO NsI=1,Ns
              G_(3+NsI)= Rr*Ur*Msf_R(NsI)
          END DO      
      ELSE 
          G_(1)= ( Sr*Rl*Ul         - Sl*Rr*Ur         + Sr*Sl*(Rr-Rl)       )/(Sr-Sl)
          G_(2)= ( Sr*(Rl*Ul**2+Pl) - Sl*(Rr*Ur**2+Pr) + Sr*Sl*(Rr*Ur-Rl*Ul) )/(Sr-Sl)                  
          G_(3)= ( Sr*(Rl*Ul*Hl)    - Sl*(Rr*Ur*Hr)    + Sr*Sl*(Rr*Er-Rl*El) )/(Sr-Sl)
          DO NsI=1,Ns
              G_(3+NsI)= (    Sr*( Rl*Ul*Msf_L(NsI) )    - Sl*( Rr*Ur*Msf_R(NsI) )   
     >                                   + Sr*Sl*( Rr*Msf_R(NsI) - Rl*Msf_L(NsI) )
     >                    )/(Sr-Sl) 

          END DO       
      END IF

      END SUBROUTINE Get_HLLEM_Flux

C=========================================================================================================
  
      SUBROUTINE Get_WTM( Msf, Mlw, WTM )
      USE Global, ONLY: Ns
      IMPLICIT NONE
      REAL*8 :: Msf(Ns),Mlw(Ns),WTM
      INTEGER :: NsI
C     Get Mean molecular weight of the gas mixture, given mass fractions, and molecular weight of each species

      WTM=0.0_8
      DO NsI=1,Ns
          WTM= WTM + Msf(NsI)/Mlw(NsI)
      END DO

      WTM= 1.0_8/WTM

      END SUBROUTINE Get_WTM