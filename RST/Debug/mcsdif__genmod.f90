        !COMPILER-GENERATED INTERFACE MODULE: Tue Dec 22 18:51:22 2015
        MODULE MCSDIF__genmod
          INTERFACE 
            SUBROUTINE MCSDIF(P,T,KDIM,RMCWRK,DJK)
              INTEGER(KIND=4) :: KDIM
              REAL(KIND=8) :: P
              REAL(KIND=8) :: T
              REAL(KIND=8) :: RMCWRK(*)
              REAL(KIND=8) :: DJK(KDIM,*)
            END SUBROUTINE MCSDIF
          END INTERFACE 
        END MODULE MCSDIF__genmod
