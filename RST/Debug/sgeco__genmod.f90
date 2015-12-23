        !COMPILER-GENERATED INTERFACE MODULE: Tue Dec 22 18:51:24 2015
        MODULE SGECO__genmod
          INTERFACE 
            SUBROUTINE SGECO(A,LDA,N,IPVT,RCOND,Z)
              INTEGER(KIND=4) :: LDA
              REAL(KIND=4) :: A(LDA,1)
              INTEGER(KIND=4) :: N
              INTEGER(KIND=4) :: IPVT(1)
              REAL(KIND=4) :: RCOND
              REAL(KIND=4) :: Z(1)
            END SUBROUTINE SGECO
          END INTERFACE 
        END MODULE SGECO__genmod
