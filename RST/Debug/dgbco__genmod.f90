        !COMPILER-GENERATED INTERFACE MODULE: Tue Dec 22 18:51:24 2015
        MODULE DGBCO__genmod
          INTERFACE 
            SUBROUTINE DGBCO(ABD,LDA,N,ML,MU,IPVT,RCOND,Z)
              INTEGER(KIND=4) :: LDA
              REAL(KIND=8) :: ABD(LDA,1)
              INTEGER(KIND=4) :: N
              INTEGER(KIND=4) :: ML
              INTEGER(KIND=4) :: MU
              INTEGER(KIND=4) :: IPVT(1)
              REAL(KIND=8) :: RCOND
              REAL(KIND=8) :: Z(1)
            END SUBROUTINE DGBCO
          END INTERFACE 
        END MODULE DGBCO__genmod
