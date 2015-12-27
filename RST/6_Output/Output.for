      SUBROUTINE Output
      USE Global
      IMPLICIT NONE
      INTEGER :: I,i2
      CHARACTER(LEN=600)  :: titles

      WRITE(NN,'(I8.8)')N

C                     Species Sequence  => H2,  O2,  O,  OH,  H2O,  H,  HO2,  H2O2,  N2
C                                 Q1(:,I)   4    5   6    7    8    9    10     11   12
      titles='X  Rho  U  P'
      OPEN(1,FILE='Result.dat',ACTION='WRITE')
          WRITE(1,'(a)')'%--------Zone T='//'  '//'1D-Reactive Shock Tube '
          WRITE(1,'(a)')'%----------------------------------------------------------------'
          WRITE(1,'(A,A,A)')'Time steps =',NN,', DATAPACKING=POINT '
          DO I=1,NS
              titles = trim(titles)//'  '//trim(SPNAME(I))
          ENDDO
          titles = trim(titles)//'  '//'T'
          WRITE(1,'(a)') trim(titles)
          DO I=1,N
              WRITE(1,'(14(E12.6,4X))') X(I),(Q1(i2,I),i2=1,NT),Tpt(I)
          END DO
      CLOSE(1)

      END SUBROUTINE Output


C==================================================Output Continue Files==================================================
      SUBROUTINE Output_Ins
      USE Global
      IMPLICIT NONE
      INTEGER :: I

      OPEN(100,FILE='BackUp.dat',ACTION='WRITE',FORM='UNFORMATTED')

          WRITE(100)Time,Iter
          WRITE(100)( Q1(:,I),I=-2,N3p )
          WRITE(100)( F1(:,I),I=-2,N3p )
          WRITE(100)( Tpt( I),I=-2,N3p )
      CLOSE(100)

      END SUBROUTINE Output_Ins
      