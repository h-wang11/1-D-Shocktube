        !COMPILER-GENERATED INTERFACE MODULE: Tue Dec 22 18:51:21 2015
        MODULE CKCDYR__genmod
          INTERFACE 
            SUBROUTINE CKCDYR(RHO,T,Y,ICKWRK,RCKWRK,CDOT,DDOT)
              REAL(KIND=8) :: RHO
              REAL(KIND=8) :: T
              REAL(KIND=8) :: Y(*)
              INTEGER(KIND=4) :: ICKWRK(*)
              REAL(KIND=8) :: RCKWRK(*)
              REAL(KIND=8) :: CDOT(*)
              REAL(KIND=8) :: DDOT(*)
            END SUBROUTINE CKCDYR
          END INTERFACE 
        END MODULE CKCDYR__genmod
