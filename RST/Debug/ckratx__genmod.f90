        !COMPILER-GENERATED INTERFACE MODULE: Tue Dec 22 18:51:19 2015
        MODULE CKRATX__genmod
          INTERFACE 
            SUBROUTINE CKRATX(II,KK,MAXSP,MAXTB,T,C,NU,NUNK,NPAR,PAR,   &
     &NFAL,IFAL,IFOP,KFAL,NFAR,FPAR,NTHB,ITHB,NTBS,AIK,NKTB,RKFT,RKRT,  &
     &RKF,RKR,CTB,NRNU,IRNU,RNU,NORD,IORD,MXORD,KORD,RORD)
              INTEGER(KIND=4) :: MXORD
              INTEGER(KIND=4) :: NFAR
              INTEGER(KIND=4) :: NPAR
              INTEGER(KIND=4) :: MAXTB
              INTEGER(KIND=4) :: MAXSP
              INTEGER(KIND=4) :: II
              INTEGER(KIND=4) :: KK
              REAL(KIND=8) :: T
              REAL(KIND=8) :: C(*)
              INTEGER(KIND=4) :: NU(MAXSP,*)
              INTEGER(KIND=4) :: NUNK(MAXSP,*)
              REAL(KIND=8) :: PAR(NPAR,*)
              INTEGER(KIND=4) :: NFAL
              INTEGER(KIND=4) :: IFAL(*)
              INTEGER(KIND=4) :: IFOP(*)
              INTEGER(KIND=4) :: KFAL(*)
              REAL(KIND=8) :: FPAR(NFAR,*)
              INTEGER(KIND=4) :: NTHB
              INTEGER(KIND=4) :: ITHB(*)
              INTEGER(KIND=4) :: NTBS(*)
              REAL(KIND=8) :: AIK(MAXTB,*)
              INTEGER(KIND=4) :: NKTB(MAXTB,*)
              REAL(KIND=8) :: RKFT(*)
              REAL(KIND=8) :: RKRT(*)
              REAL(KIND=8) :: RKF(*)
              REAL(KIND=8) :: RKR(*)
              REAL(KIND=8) :: CTB(*)
              INTEGER(KIND=4) :: NRNU
              INTEGER(KIND=4) :: IRNU(*)
              REAL(KIND=8) :: RNU(MAXSP,*)
              INTEGER(KIND=4) :: NORD
              INTEGER(KIND=4) :: IORD(*)
              INTEGER(KIND=4) :: KORD(MXORD,*)
              REAL(KIND=8) :: RORD(MXORD,*)
            END SUBROUTINE CKRATX
          END INTERFACE 
        END MODULE CKRATX__genmod
