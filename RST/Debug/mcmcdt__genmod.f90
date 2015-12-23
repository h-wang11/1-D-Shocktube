        !COMPILER-GENERATED INTERFACE MODULE: Tue Dec 22 18:51:22 2015
        MODULE MCMCDT__genmod
          INTERFACE 
            SUBROUTINE MCMCDT(P,T,X,IMCWRK,RMCWRK,ICKWRK,CKWRK,DT,COND)
              REAL(KIND=8) :: P
              REAL(KIND=8) :: T
              REAL(KIND=8) :: X(*)
              INTEGER(KIND=4) :: IMCWRK(*)
              REAL(KIND=8) :: RMCWRK(*)
              INTEGER(KIND=4) :: ICKWRK(*)
              REAL(KIND=8) :: CKWRK(*)
              REAL(KIND=8) :: DT(*)
              REAL(KIND=8) :: COND
            END SUBROUTINE MCMCDT
          END INTERFACE 
        END MODULE MCMCDT__genmod
