        !COMPILER-GENERATED INTERFACE MODULE: Tue Dec 22 18:51:22 2015
        MODULE MCEPSG__genmod
          INTERFACE 
            SUBROUTINE MCEPSG(KK,EPS,SIG,DIP,POL,EOK,SGM)
              INTEGER(KIND=4) :: KK
              REAL(KIND=8) :: EPS(*)
              REAL(KIND=8) :: SIG(*)
              REAL(KIND=8) :: DIP(*)
              REAL(KIND=8) :: POL(*)
              REAL(KIND=8) :: EOK(KK,*)
              REAL(KIND=8) :: SGM(KK,*)
            END SUBROUTINE MCEPSG
          END INTERFACE 
        END MODULE MCEPSG__genmod
