        !COMPILER-GENERATED INTERFACE MODULE: Tue Dec 22 18:51:24 2015
        MODULE SGBSL__genmod
          INTERFACE 
            SUBROUTINE SGBSL(ABD,LDA,N,ML,MU,IPVT,B,JOB)
              INTEGER(KIND=4) :: LDA
              REAL(KIND=4) :: ABD(LDA,1)
              INTEGER(KIND=4) :: N
              INTEGER(KIND=4) :: ML
              INTEGER(KIND=4) :: MU
              INTEGER(KIND=4) :: IPVT(1)
              REAL(KIND=4) :: B(1)
              INTEGER(KIND=4) :: JOB
            END SUBROUTINE SGBSL
          END INTERFACE 
        END MODULE SGBSL__genmod
