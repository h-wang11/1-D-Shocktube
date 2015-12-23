        !COMPILER-GENERATED INTERFACE MODULE: Tue Dec 22 18:51:22 2015
        MODULE MCORDF__genmod
          INTERFACE 
            SUBROUTINE MCORDF(P,T,X,KK,KDIM,SMALL,WT,RMCWRK,XX,BINDIF,  &
     &XL0000,WORK,IPVT,D)
              INTEGER(KIND=4) :: KDIM
              INTEGER(KIND=4) :: KK
              REAL(KIND=8) :: P
              REAL(KIND=8) :: T
              REAL(KIND=8) :: X(*)
              REAL(KIND=8) :: SMALL
              REAL(KIND=8) :: WT(*)
              REAL(KIND=8) :: RMCWRK(*)
              REAL(KIND=8) :: XX(*)
              REAL(KIND=8) :: BINDIF(KK,*)
              REAL(KIND=8) :: XL0000(KK,*)
              REAL(KIND=8) :: WORK(*)
              INTEGER(KIND=4) :: IPVT(*)
              REAL(KIND=8) :: D(KDIM,*)
            END SUBROUTINE MCORDF
          END INTERFACE 
        END MODULE MCORDF__genmod
