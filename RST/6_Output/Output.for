      SUBROUTINE Output
      USE Global
      IMPLICIT NONE
      INTEGER :: I
      REAL*8 :: Temperature,Entropy

      WRITE(NN,'(I8.8)')N

      OPEN(1,FILE='Result.dat',ACTION='WRITE')
          WRITE(1,'(A,A)')'Variables= ',' "X" "U" "Rho" "P" "T" "S"  '
          WRITE(1,'(4A)')'Zone T=','"','1D-Euler Euqations','"'
          WRITE(1,'(A,A,A)')'I=',NN,', DATAPACKING=POINT '

          DO I=1,N
              Temperature=Q1(3,I)/Q1(1,I)
              Entropy=Q1(3,I)/Q1(1,I)**Gamma
              WRITE(1,'(6(E12.6,4X))')X(I),Q1(2,I),Q1(1,I),Q1(3,I),Temperature,Entropy
          END DO

      CLOSE(1)

      END SUBROUTINE Output