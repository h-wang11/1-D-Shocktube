      SUBROUTINE Output
      USE Global
      IMPLICIT NONE
      INTEGER :: I

      WRITE(NN,'(I8.8)')N

      OPEN(1,FILE='Result.dat',ACTION='WRITE')
          WRITE(1,'(A,A)')'Variables= ',' "X" "U" "Rho" "P" "T" "N2" "H2" "O2" '
          WRITE(1,'(4A)')'Zone T=','"','1D-Reactive Shock Tube','"'
          WRITE(1,'(A,A,A)')'I=',NN,', DATAPACKING=POINT '

          DO I=1,N

              WRITE(1,'(8(E12.6,4X))')X(I),Q1(2,I),Q1(1,I),Q1(3,I),Tpt(I),Q1(12,I),Q1(4,I),Q1(5,I)
          END DO

      CLOSE(1)

      END SUBROUTINE Output