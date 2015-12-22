      SUBROUTINE Update
      USE Global
      IMPLICIT NONE
      INTEGER :: I
C     Update Variables
          
          SELECT CASE(T_Kind)
              CASE(2,3)
                  F0=F1
                  F1=F
              CASE(4)
                  F0=F
                  F=F1
          END SELECT
          
          DO I=1,N
          
              Q1(1,I)=F1(1,I)                                                    ! rho
              Q1(2,I)=F1(2,I)/Q1(1,I)                                            ! u
              Q1(3,I)=( F1(3,I)-0.5_8*Q1(1,I)*( Q1(2,I)**2 ) )*(Gamma-1.0_8)     ! p

          END DO
          
      END SUBROUTINE Update
C==================================================================================================
      SUBROUTINE Update_RK
      USE Global
      IMPLICIT NONE
      INTEGER :: I
C     Update Variables for 3rd-Explicit_TVD Runge-Kutta 
          
          F2=F0
          F0=F1
          F1=F
          
          DO I=1,N
          
              Q1(1,I)=F1(1,I)                                                    ! rho
              Q1(2,I)=F1(2,I)/Q1(1,I)                                            ! u
              Q1(3,I)=( F1(3,I)-0.5_8*Q1(1,I)*( Q1(2,I)**2 ) )*(Gamma-1.0_8)     ! p

          END DO
          
      END SUBROUTINE Update_RK
C==================================================================================================
      SUBROUTINE Update_Sub
      USE Global
      IMPLICIT NONE
      INTEGER :: I
C     Update Variables for Sub Iteration of LU-SGS
          
          F2=F1

          DO I=1,N
          
              Q1(1,I)=F2(1,I)                                                    ! rho
              Q1(2,I)=F2(2,I)/Q1(1,I)                                            ! u
              Q1(3,I)=( F2(3,I)-0.5_8*Q1(1,I)*( Q1(2,I)**2 ) )*(Gamma-1.0_8)     ! p

          END DO
          
      END SUBROUTINE Update_Sub