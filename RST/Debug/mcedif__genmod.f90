        !COMPILER-GENERATED INTERFACE MODULE: Tue Dec 22 18:51:22 2015
        MODULE MCEDIF__genmod
          INTERFACE 
            SUBROUTINE MCEDIF(T,NO,KK,X,COFD,WT,SMALL,XX,DJK,D)
              INTEGER(KIND=4) :: KK
              INTEGER(KIND=4) :: NO
              REAL(KIND=8) :: T
              REAL(KIND=8) :: X(*)
              REAL(KIND=8) :: COFD(NO,KK,*)
              REAL(KIND=8) :: WT(*)
              REAL(KIND=8) :: SMALL
              REAL(KIND=8) :: XX(*)
              REAL(KIND=8) :: DJK(KK,*)
              REAL(KIND=8) :: D(*)
            END SUBROUTINE MCEDIF
          END INTERFACE 
        END MODULE MCEDIF__genmod
