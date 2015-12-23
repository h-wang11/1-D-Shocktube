        !COMPILER-GENERATED INTERFACE MODULE: Tue Dec 22 18:51:22 2015
        MODULE MCMDIF__genmod
          INTERFACE 
            SUBROUTINE MCMDIF(P,T,X,KDIM,IMCWRK,RMCWRK,D)
              INTEGER(KIND=4) :: KDIM
              REAL(KIND=8) :: P
              REAL(KIND=8) :: T
              REAL(KIND=8) :: X(*)
              INTEGER(KIND=4) :: IMCWRK(*)
              REAL(KIND=8) :: RMCWRK(*)
              REAL(KIND=8) :: D(KDIM,*)
            END SUBROUTINE MCMDIF
          END INTERFACE 
        END MODULE MCMDIF__genmod
