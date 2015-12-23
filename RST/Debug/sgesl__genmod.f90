        !COMPILER-GENERATED INTERFACE MODULE: Tue Dec 22 18:51:24 2015
        MODULE SGESL__genmod
          INTERFACE 
            SUBROUTINE SGESL(A,LDA,N,IPVT,B,JOB)
              INTEGER(KIND=4) :: LDA
              REAL(KIND=4) :: A(LDA,1)
              INTEGER(KIND=4) :: N
              INTEGER(KIND=4) :: IPVT(1)
              REAL(KIND=4) :: B(1)
              INTEGER(KIND=4) :: JOB
            END SUBROUTINE SGESL
          END INTERFACE 
        END MODULE SGESL__genmod
