        !COMPILER-GENERATED INTERFACE MODULE: Tue Dec 22 18:51:24 2015
        MODULE SGBCO__genmod
          INTERFACE 
            SUBROUTINE SGBCO(ABD,LDA,N,ML,MU,IPVT,RCOND,Z)
              INTEGER(KIND=4) :: LDA
              REAL(KIND=4) :: ABD(LDA,1)
              INTEGER(KIND=4) :: N
              INTEGER(KIND=4) :: ML
              INTEGER(KIND=4) :: MU
              INTEGER(KIND=4) :: IPVT(1)
              REAL(KIND=4) :: RCOND
              REAL(KIND=4) :: Z(1)
            END SUBROUTINE SGBCO
          END INTERFACE 
        END MODULE SGBCO__genmod
