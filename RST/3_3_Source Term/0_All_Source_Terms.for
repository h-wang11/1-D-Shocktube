      SUBROUTINE Get_All_Source
      USE Chem
      USE Global
      IMPLICIT NONE
      INTEGER :: I,NsI
      REAL*8 :: Mlf(Ns)   ! Mole fractions of species
C     Get All the Chemical Reaction Species Production Rates

              DO I=1,N

C                 ¡¾Molar Production Rates of the Species¡¿ [ mol/(cm**3*s) ] 
                  Gs(1:3,I)=0.0_8
                  CALL CKWYR( Q1(1,I), Tpt(I), Q1(4:NT,I), IWORK, RWORK, Gs(4:NT,I) )
C                 Cklib.f\ CKWYR( RHO, T, Y, ICKWRK, RCKWRK, WDOT )
C                     Returns the molar production rates of the species given the mass density, temperature and mass fractions
C                     Input:
C                         Rho    - Mass density. [ g/cm**3 ]      
C                         T      - Temperature. [ K ]         
C                         Y      - Mass fractions of the species.  
C                         ICKWRK - Array of integer workspace.
C                         RCKWRK - Array of real work space.
C                     Output:
C                         WDOT   - Chemical molar production rates of the species. [ mol/(cm**3*s) ] 

                  DO NsI=1,Ns
C                     [ mol/(cm**3*sec) ] => [ g/(cm*3*s) ]
                      Gs(3+NsI,I)=Gs(3+NsI,I)*Mlw(NsI)
                  END DO

              END DO

      END SUBROUTINE Get_All_Source  