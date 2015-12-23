        !COMPILER-GENERATED INTERFACE MODULE: Tue Dec 22 18:51:24 2015
        MODULE DGECO__genmod
          INTERFACE 
            SUBROUTINE DGECO(A,LDA,N,IPVT,RCOND,Z)
              INTEGER(KIND=4) :: LDA
              REAL(KIND=8) :: A(LDA,1)
              INTEGER(KIND=4) :: N
              INTEGER(KIND=4) :: IPVT(1)
              REAL(KIND=8) :: RCOND
              REAL(KIND=8) :: Z(1)
            END SUBROUTINE DGECO
          END INTERFACE 
        END MODULE DGECO__genmod
