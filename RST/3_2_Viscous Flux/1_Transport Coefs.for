      SUBROUTINE Get_All_Transport_Coefs
      USE Chem
      USE Global
      IMPLICIT NONE
      INTEGER :: I
      REAL*8 :: Mlf(Ns)   ! Mole fractions of species
C     Get All the Transport Coefficients below :
C         ¡¾ Mu ¡¿ The Viscousity at cell center of the Gas Mixture need to be calculated ahead, using CHEMIKIN
C         ¡¾ Cc ¡¿ The Thermal Conductivity at cell center of the Gas Mixture need to be calculated ahead, using CHEMIKIN
C         ¡¾ Dfc¡¿ The Diffusivity at cell center of each species need to be calculated ahead, using CHEMIKIN

          DO I=0,N1p

C             ¡¾ Mass fraction to Mole fraction ¡¿
              CALL CKYTX( Q1(4:NT,I), IWORK, RWORK, Mlf )

C             ¡¾ Mixture-Averaged Mass Diffusion Coefficients ¡¿  [ cm**2/s ]
              CALL MCADIF( Q1(3,I), Tpt(I), Mlf, RMCWRK, Dfc(:,I) )
C             Tranlib.f\ MCADIF( P, T, X, RMCWRK, D )
C                 THIS SUBROUTINE COMPUTES MIXTURE-AVERAGED DIFFUSION COEFFICIENTS
C                 GIVEN THE PRESSURE, TEMPERATURE, AND SPECIES MOLE FRACTIONS.
C                 Input:
C                         P       - PRESSURE  [ DYNES/CM**2 ] CGS-UNITs
C                         T       - TEMPERATURE [ K ]
C                         X       - ARRAY OF MOLE FRACTIONS OF THE MIXTURE.
C                         RMCWRK  - ARRAY OF FLOATING POINT STORAGE AND WORK SPACE.
C                 Output:
C                         D       - ARRAY OF MIXTURE DIFFUSION COEFFICIENTS [ cm**2/s ]

C             ¡¾ Thermal Conductivity ¡¿  [ ergs/(cm*K*s) ]
              CALL MCACON( Tpt(I), Mlf, RMCWRK, Cc(I) )  
C             Tranlib.f\ MCACON( T, X, RMCWRK, CONMIX )
C                 THIS SUBROUTINE COMPUTES THE MIXTURE THERMAL CONDUCTIVITY, GIVEN
C                 THE TEMPERATURE AND THE SPECIES MOLE FRACTIONS.
C                 Input:
C                         T       - TEMPERATURE  [ K ]
C                         X       - ARRAY OF MOLE FRACTIONS OF THE MIXTURE.
C                         RMCWRK  - ARRAY OF FLOATING POINT STORAGE AND WORK SPACE.
C                 Output:
C                         CONMIX  - MIXTURE THERMAL CONDUCTIVITY [ ergs/(cm*K*s) ]

C             ¡¾ Viscousity Coefficient ¡¿  [ g/cm*s ]
              CALL MCAVIS( Tpt(I), Mlf, RMCWRK, Mu(I) )
C             Tranlib.f\ MCAVIS( T, X, RMCWRK, VISMIX )
C             THIS SUBROUTINE COMPUTES THE MIXTURE VISCOSITY, GIVEN THE TEMPERATURE AND THE SPECIES MOLE FRACTIONS.  
C             IT USES MODIFICATI OF THE WILKE SEMI-EMPIRICAL FORMULAS.
C             Input:
C                     T       - TEMPERATURE [ K ]
C                     X       - ARRAY OF MOLE FRACTIONS OF THE MIXTURE.
C                     RMCWRK  - ARRAY OF FLOATING POINT STORAGE AND WORK SPACE.
C             Output:
C                     VISMIX  - MIXTURE VISCOSITY [ g/cm*s ]
              

          END DO
      
      END SUBROUTINE Get_All_Transport_Coefs    