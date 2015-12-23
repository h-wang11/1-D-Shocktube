        !COMPILER-GENERATED INTERFACE MODULE: Tue Dec 22 18:51:18 2015
        MODULE CKATHM__genmod
          INTERFACE 
            SUBROUTINE CKATHM(NDIM1,NDIM2,ICKWRK,RCKWRK,MAXTP,NT,TMP,A)
              INTEGER(KIND=4) :: MAXTP
              INTEGER(KIND=4) :: NDIM2
              INTEGER(KIND=4) :: NDIM1
              INTEGER(KIND=4) :: ICKWRK(*)
              REAL(KIND=8) :: RCKWRK(*)
              INTEGER(KIND=4) :: NT(*)
              REAL(KIND=8) :: TMP(MAXTP,*)
              REAL(KIND=8) :: A(NDIM1,NDIM2,*)
            END SUBROUTINE CKATHM
          END INTERFACE 
        END MODULE CKATHM__genmod
