      SUBROUTINE Output
      USE Global
      IMPLICIT NONE
      INTEGER :: I

      WRITE(NN,'(I8.8)')N

C                     Species Sequence  => H2,  O2,  O,  OH,  H2O,  H,  HO2,  H2O2,  N2
C                                 Q1(:,I)   4    5   6    7    8    9    10     11   12

      OPEN(1,FILE='Result.dat',ACTION='WRITE')
          WRITE(1,'(A,A)')'Variables= ',' "X" "U" "Rho" "P" "T" "N2" "H2" "O2" "OH" "O" "H2O" "H" "HO2" "H2O2" '
          WRITE(1,'(4A)')'Zone T=','"','1D-Reactive Shock Tube','"'
          WRITE(1,'(A,A,A)')'I=',NN,', DATAPACKING=POINT '

          DO I=1,N

              WRITE(1,'(14(E12.6,4X))')X(I),Q1(2,I),Q1(1,I),Q1(3,I),Tpt(I),Q1(12,I),Q1( 4,I),Q1( 5,I),
     >                                                                     Q1( 7,I),Q1( 6,I),Q1( 8,I),
     >                                                                     Q1( 9,I),Q1(10,I),Q1(11,I)
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
      