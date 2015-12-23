      SUBROUTINE BC
      USE Global
      IMPLICIT NONE
      INTEGER :: I
      
C         Non-Reflection Farfield

          DO I=-2,0
              Q1(:,I)=Q1(:,1)
              F1(:,I)=F1(:,1)    
          END DO
          
          DO I=N1p,N3p
              Q1(:,I)=Q1(:,N)
              F1(:,I)=F1(:,N)
          END DO

      END SUBROUTINE