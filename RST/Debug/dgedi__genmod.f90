        !COMPILER-GENERATED INTERFACE MODULE: Tue Dec 22 18:51:24 2015
        MODULE DGEDI__genmod
          INTERFACE 
            SUBROUTINE DGEDI(A,LDA,N,IPVT,DET,WORK,JOB)
              INTEGER(KIND=4) :: LDA
              REAL(KIND=8) :: A(LDA,1)
              INTEGER(KIND=4) :: N
              INTEGER(KIND=4) :: IPVT(1)
              REAL(KIND=8) :: DET(2)
              REAL(KIND=8) :: WORK(1)
              INTEGER(KIND=4) :: JOB
            END SUBROUTINE DGEDI
          END INTERFACE 
        END MODULE DGEDI__genmod
