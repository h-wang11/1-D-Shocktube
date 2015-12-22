      SUBROUTINE Get_AUSMPW_Plus_Flux(Rl,Rr,Ul,Ur,Pl,Pr,Msf_L,Msf_R, G_)   ! Only G_ is Output
      USE Global, ONLY: Gamma,Ns,NT
      IMPLICIT NONE
C     AUSMPW+ for convective numerical flux
      
      REAL*8 :: Rl,Rr,Ul,Ur,Pl,Pr,Hl,Hr                 ! H = Enthalpy
      REAL*8 :: Msf_L(Ns),Msf_R(Ns),G_(NT)
      REAL*8 :: Sl,Sr                                   ! S = Sonic Speed
      REAL*8 :: ML,MR,ML_,MR_,MH,PL_,PR_

      Hl=Gamma/(Gamma-1)*Pl/Rl+0.5*( Ul**2 )
      Hr=Gamma/(Gamma-1)*Pr/Rr+0.5*( Ur**2 )

C     Sonic Speed
      Sl=SQRT(Gamma*Pl/Rl)
      Sr=SQRT(Gamma*Pr/Rr)

C     Ma Number
      ML=Ul/Sl
      MR=Ur/Sr
      CALL Ma_Split(ML,1,ML_)
      CALL Ma_Split(MR,2,MR_)
      MH=ML_+MR_
     

C     Pressure Term
      CALL P_Split(PL,ML,1,PL_,1)   ! 1,2 两种压力分裂方式, 本质上还是根据经验搞出来的
      CALL P_Split(PR,MR,2,PR_,1)

C     Flux
      IF (MH.GE.0) THEN
          G1= MH*Rl*Sl
          G2= MH*Rl*Sl*Ul + ( PL_ + PR_ )
          G3= MH*Rl*Sl*Hl
      ELSE IF (MH.LE.0) THEN
          G1= MH*Rr*Sr
          G2= MH*Rr*Sr*Ur + ( PL_ + PR_ )
          G3= MH*Rr*Sr*Hr 
      END IF


      END SUBROUTINE Get_AUSMPW_Plus_Flux

C========================================各种奇葩分裂========================================
      SUBROUTINE Ma_Split(M,LR,M_)
      IMPLICIT NONE
      REAL*8 :: M,M_
      INTEGER :: LR   ! LR 表示左右
C     Ma 数分裂

          IF ( ABS(M).LE.1 ) THEN
              SELECT CASE(LR)
C             左侧还是右侧
                  CASE(1) ! 左侧
                      M_=0.25*(M+1.0)**2
                  CASE(2) ! 右侧
                      M_=-0.25*(M-1.0)**2
              END SELECT
          ELSE
              SELECT CASE(LR)
                  CASE(1) 
                      M_=0.5*( M+ABS(M) )
                  CASE(2)
                      M_=0.5*( M-ABS(M) )
              END SELECT 
          END IF
      END SUBROUTINE Ma_Split
C-------------------------------------------------------
C-------------------------------------------------------
      SUBROUTINE P_Split(P,M,LR,P_,Kind_)
      IMPLICIT NONE
      REAL*8 :: M,P,P_
      INTEGER :: LR,Kind_   ! LR 表示左右,Kind_表示分裂方式
C     Pressure 分裂

      SELECT CASE(Kind_)
          CASE(1)
C         Split Type-1
              IF ( ABS(M).LE.1 ) THEN
                  SELECT CASE(LR)
C                 左侧还是右侧
                      CASE(1) ! 左侧
                          P_=0.5*P*(1+M)
                      CASE(2) ! 右侧
                          P_=0.5*P*(1-M)
                  END SELECT
              ELSE
                  SELECT CASE(LR)
                      CASE(1) 
                          P_=0.5*P*( M+ABS(M) )/M
                      CASE(2)
                          P_=0.5*P*( M-ABS(M) )/M
                  END SELECT 
              END IF

          CASE(2)
C         Split Type-2
              IF ( ABS(M).LE.1 ) THEN
                  SELECT CASE(LR)
C                 左侧还是右侧
                      CASE(1) ! 左侧
                          P_=0.25*P*(1+M)**2*(2-M)
                      CASE(2) ! 右侧
                          P_=0.25*P*(1-M)**2*(2+M)
                  END SELECT
              ELSE
                  SELECT CASE(LR)
                      CASE(1) 
                          P_=0.5*P*( M+ABS(M) )/M
                      CASE(2)
                          P_=0.5*P*( M-ABS(M) )/M
                  END SELECT 
              END IF
      END SELECT

      END SUBROUTINE P_Split
  
