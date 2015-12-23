        !COMPILER-GENERATED INTERFACE MODULE: Tue Dec 22 18:51:20 2015
        MODULE CKRATT__genmod
          INTERFACE 
            SUBROUTINE CKRATT(RCKWRK,ICKWRK,II,MAXSP,RU,PATM,T,NSPEC,NU,&
     &NUNK,NPAR,PAR,NREV,IREV,RPAR,NLAN,NLAR,ILAN,PLT,NRLT,IRLT,RPLT,SMH&
     &,NRNU,IRNU,RNU,NEIM,IEIM,ITDEP,NJAN,NJAR,IJAN,PJAN,NFT1,NF1R,IFT1,&
     &PF1,RKFT,RKRT,EQK)
              INTEGER(KIND=4) :: NF1R
              INTEGER(KIND=4) :: NJAR
              INTEGER(KIND=4) :: NLAR
              INTEGER(KIND=4) :: NPAR
              INTEGER(KIND=4) :: MAXSP
              REAL(KIND=8) :: RCKWRK(*)
              INTEGER(KIND=4) :: ICKWRK(*)
              INTEGER(KIND=4) :: II
              REAL(KIND=8) :: RU
              REAL(KIND=8) :: PATM
              REAL(KIND=8) :: T(*)
              INTEGER(KIND=4) :: NSPEC(*)
              INTEGER(KIND=4) :: NU(MAXSP,*)
              INTEGER(KIND=4) :: NUNK(MAXSP,*)
              REAL(KIND=8) :: PAR(NPAR,*)
              INTEGER(KIND=4) :: NREV
              INTEGER(KIND=4) :: IREV(*)
              REAL(KIND=8) :: RPAR(NPAR,*)
              INTEGER(KIND=4) :: NLAN
              INTEGER(KIND=4) :: ILAN(*)
              REAL(KIND=8) :: PLT(NLAR,*)
              INTEGER(KIND=4) :: NRLT
              INTEGER(KIND=4) :: IRLT(*)
              REAL(KIND=8) :: RPLT(NLAR,*)
              REAL(KIND=8) :: SMH(*)
              INTEGER(KIND=4) :: NRNU
              INTEGER(KIND=4) :: IRNU(*)
              REAL(KIND=8) :: RNU(MAXSP,*)
              INTEGER(KIND=4) :: NEIM
              INTEGER(KIND=4) :: IEIM(*)
              INTEGER(KIND=4) :: ITDEP(*)
              INTEGER(KIND=4) :: NJAN
              INTEGER(KIND=4) :: IJAN(*)
              REAL(KIND=8) :: PJAN(NJAR,*)
              INTEGER(KIND=4) :: NFT1
              INTEGER(KIND=4) :: IFT1(*)
              REAL(KIND=8) :: PF1(NF1R,*)
              REAL(KIND=8) :: RKFT(*)
              REAL(KIND=8) :: RKRT(*)
              REAL(KIND=8) :: EQK(*)
            END SUBROUTINE CKRATT
          END INTERFACE 
        END MODULE CKRATT__genmod
