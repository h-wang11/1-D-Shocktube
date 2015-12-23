        !COMPILER-GENERATED INTERFACE MODULE: Tue Dec 22 18:51:22 2015
        MODULE MCLMDT__genmod
          INTERFACE 
            SUBROUTINE MCLMDT(P,T,X,KK,KK3,SMALL,WT,EOK,ZROT,LIN,EPS,   &
     &ICKWRK,CKWRK,RMCWRK,XX,VIS,ASTAR,BSTAR,CSTAR,XI,CPOR,CROTOR,CINTOR&
     &,XL,R,BINDIF,IPVT,DT,COND)
              INTEGER(KIND=4) :: KK3
              INTEGER(KIND=4) :: KK
              REAL(KIND=8) :: P
              REAL(KIND=8) :: T
              REAL(KIND=8) :: X(*)
              REAL(KIND=8) :: SMALL
              REAL(KIND=8) :: WT(*)
              REAL(KIND=8) :: EOK(KK,*)
              REAL(KIND=8) :: ZROT(*)
              INTEGER(KIND=4) :: LIN(*)
              REAL(KIND=8) :: EPS(*)
              INTEGER(KIND=4) :: ICKWRK(*)
              REAL(KIND=8) :: CKWRK(*)
              REAL(KIND=8) :: RMCWRK(*)
              REAL(KIND=8) :: XX(*)
              REAL(KIND=8) :: VIS(*)
              REAL(KIND=8) :: ASTAR(KK,*)
              REAL(KIND=8) :: BSTAR(KK,*)
              REAL(KIND=8) :: CSTAR(KK,*)
              REAL(KIND=8) :: XI(*)
              REAL(KIND=8) :: CPOR(*)
              REAL(KIND=8) :: CROTOR(*)
              REAL(KIND=8) :: CINTOR(*)
              REAL(KIND=8) :: XL(KK3,*)
              REAL(KIND=8) :: R(*)
              REAL(KIND=8) :: BINDIF(KK,*)
              INTEGER(KIND=4) :: IPVT(*)
              REAL(KIND=8) :: DT(*)
              REAL(KIND=8) :: COND
            END SUBROUTINE MCLMDT
          END INTERFACE 
        END MODULE MCLMDT__genmod
