        !COMPILER-GENERATED INTERFACE MODULE: Tue Dec 22 18:51:24 2015
        MODULE SGEDI__genmod
          INTERFACE 
            SUBROUTINE SGEDI(A,LDA,N,IPVT,DET,WORK,JOB)
              INTEGER(KIND=4) :: LDA
              REAL(KIND=4) :: A(LDA,1)
              INTEGER(KIND=4) :: N
              INTEGER(KIND=4) :: IPVT(1)
              REAL(KIND=4) :: DET(2)
              REAL(KIND=4) :: WORK(1)
              INTEGER(KIND=4) :: JOB
            END SUBROUTINE SGEDI
          END INTERFACE 
        END MODULE SGEDI__genmod
