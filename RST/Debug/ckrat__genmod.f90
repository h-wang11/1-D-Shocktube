        !COMPILER-GENERATED INTERFACE MODULE: Tue Dec 22 18:51:20 2015
        MODULE CKRAT__genmod
          INTERFACE 
            SUBROUTINE CKRAT(RCKWRK,ICKWRK,II,KK,MAXSP,MAXTB,RU,PATM,T,C&
     &,NSPEC,NU,NUNK,NPAR,PAR,NREV,IREV,RPAR,NFAL,IFAL,IFOP,KFAL,NFAR,  &
     &FPAR,NLAN,NLAR,ILAN,PLT,NRLT,IRLT,RPLT,NTHB,ITHB,NTBS,AIK,NKTB,SMH&
     &,RKFT,RKRT,RKF,RKR,EQK,CTB,NRNU,IRNU,RNU,NORD,IORD,MXORD,KORD,RORD&
     &)
              INTEGER(KIND=4) :: MXORD
              INTEGER(KIND=4) :: NLAR
              INTEGER(KIND=4) :: NFAR
              INTEGER(KIND=4) :: NPAR
              INTEGER(KIND=4) :: MAXTB
              INTEGER(KIND=4) :: MAXSP
              REAL(KIND=8) :: RCKWRK(*)
              INTEGER(KIND=4) :: ICKWRK(*)
              INTEGER(KIND=4) :: II
              INTEGER(KIND=4) :: KK
              REAL(KIND=8) :: RU
              REAL(KIND=8) :: PATM
              REAL(KIND=8) :: T
              REAL(KIND=8) :: C(*)
              INTEGER(KIND=4) :: NSPEC(*)
              INTEGER(KIND=4) :: NU(MAXSP,*)
              INTEGER(KIND=4) :: NUNK(MAXSP,*)
              REAL(KIND=8) :: PAR(NPAR,*)
              INTEGER(KIND=4) :: NREV
              INTEGER(KIND=4) :: IREV(*)
              REAL(KIND=8) :: RPAR(NPAR,*)
              INTEGER(KIND=4) :: NFAL
              INTEGER(KIND=4) :: IFAL(*)
              INTEGER(KIND=4) :: IFOP(*)
              INTEGER(KIND=4) :: KFAL(*)
              REAL(KIND=8) :: FPAR(NFAR,*)
              INTEGER(KIND=4) :: NLAN
              INTEGER(KIND=4) :: ILAN(*)
              REAL(KIND=8) :: PLT(NLAR,*)
              INTEGER(KIND=4) :: NRLT
              INTEGER(KIND=4) :: IRLT(*)
              REAL(KIND=8) :: RPLT(NLAR,*)
              INTEGER(KIND=4) :: NTHB
              INTEGER(KIND=4) :: ITHB(*)
              INTEGER(KIND=4) :: NTBS(*)
              REAL(KIND=8) :: AIK(MAXTB,*)
              INTEGER(KIND=4) :: NKTB(MAXTB,*)
              REAL(KIND=8) :: SMH(*)
              REAL(KIND=8) :: RKFT(*)
              REAL(KIND=8) :: RKRT(*)
              REAL(KIND=8) :: RKF(*)
              REAL(KIND=8) :: RKR(*)
              REAL(KIND=8) :: EQK(*)
              REAL(KIND=8) :: CTB(*)
              INTEGER(KIND=4) :: NRNU
              INTEGER(KIND=4) :: IRNU(*)
              REAL(KIND=8) :: RNU(MAXSP,*)
              INTEGER(KIND=4) :: NORD
              INTEGER(KIND=4) :: IORD(*)
              INTEGER(KIND=4) :: KORD(MXORD,*)
              REAL(KIND=8) :: RORD(MXORD,*)
            END SUBROUTINE CKRAT
          END INTERFACE 
        END MODULE CKRAT__genmod
