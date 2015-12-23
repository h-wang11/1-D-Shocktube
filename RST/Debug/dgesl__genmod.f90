        !COMPILER-GENERATED INTERFACE MODULE: Tue Dec 22 18:51:24 2015
        MODULE DGESL__genmod
          INTERFACE 
            SUBROUTINE DGESL(A,LDA,N,IPVT,B,JOB)
              INTEGER(KIND=4) :: LDA
              REAL(KIND=8) :: A(LDA,1)
              INTEGER(KIND=4) :: N
              INTEGER(KIND=4) :: IPVT(1)
              REAL(KIND=8) :: B(1)
              INTEGER(KIND=4) :: JOB
            END SUBROUTINE DGESL
          END INTERFACE 
        END MODULE DGESL__genmod
