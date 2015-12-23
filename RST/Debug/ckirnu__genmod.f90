        !COMPILER-GENERATED INTERFACE MODULE: Tue Dec 22 18:51:18 2015
        MODULE CKIRNU__genmod
          INTERFACE 
            SUBROUTINE CKIRNU(IDIM,NDIM,ICKWRK,RCKWRK,NIRNU,IRNU,NSPEC, &
     &KI,RNU)
              INTEGER(KIND=4) :: NDIM
              INTEGER(KIND=4) :: IDIM
              INTEGER(KIND=4) :: ICKWRK(*)
              REAL(KIND=8) :: RCKWRK(*)
              INTEGER(KIND=4) :: NIRNU
              INTEGER(KIND=4) :: IRNU(*)
              INTEGER(KIND=4) :: NSPEC(*)
              INTEGER(KIND=4) :: KI(NDIM,*)
              REAL(KIND=8) :: RNU(NDIM,*)
            END SUBROUTINE CKIRNU
          END INTERFACE 
        END MODULE CKIRNU__genmod
