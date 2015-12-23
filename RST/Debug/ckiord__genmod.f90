        !COMPILER-GENERATED INTERFACE MODULE: Tue Dec 22 18:51:18 2015
        MODULE CKIORD__genmod
          INTERFACE 
            SUBROUTINE CKIORD(IDIM,KDIM,ICKWRK,RCKWRK,NFORD,IFORD,FORD, &
     &NRORD,IRORD,RORD)
              INTEGER(KIND=4) :: KDIM
              INTEGER(KIND=4) :: IDIM
              INTEGER(KIND=4) :: ICKWRK(*)
              REAL(KIND=8) :: RCKWRK(*)
              INTEGER(KIND=4) :: NFORD
              INTEGER(KIND=4) :: IFORD(*)
              REAL(KIND=8) :: FORD(KDIM,*)
              INTEGER(KIND=4) :: NRORD
              INTEGER(KIND=4) :: IRORD(*)
              REAL(KIND=8) :: RORD(KDIM,*)
            END SUBROUTINE CKIORD
          END INTERFACE 
        END MODULE CKIORD__genmod
