      SUBROUTINE BC
      USE Global
      IMPLICIT NONE
      INTEGER :: I,IL,IR1,IR2
      

      SELECT CASE( BC_Kind )
          CASE(1)
C         Non-Reflection Farfield

              DO I=-2,0
                  Q1(:,I)=Q1(:,1)
                  F1(:,I)=F1(:,1)    
              END DO
          
              DO I=N1p,N3p
                  Q1(:,I)=Q1(:,N)
                  F1(:,I)=F1(:,N)
              END DO

          CASE(2)
C         Reflective Wall Boundary Conditions
C             Density, Mass Fractions, and Pressure are the same
C             Only, Velocity Changes Sign
              DO I=0,-2,-1
C             Left Side
                  IL=1-I
C                 Primitive Variables
                  Q1(:,I)= Q1(:,IL)
                  Q1(2,I)=-Q1(2,IL)    ! Reverse Velocity

C                 Conserved Variables
                  F1(:,I)= F1(:,IL) 
                  F1(2,I)=-F1(2,IL)    ! Reverse Momentum: rho*u

C             Right Side
                  IR1=N+1-I
                  IR2=N+I
C                 Primitive Variables
                  Q1(:,IR1)= Q1(:,IR2)
                  Q1(2,IR1)=-Q1(2,IR2)  

C                 Conserved Variables
                  F1(:,IR1)= F1(:,IR2) 
                  F1(2,IR1)=-F1(2,IR2)

              END DO

      END SELECT

      END SUBROUTINE