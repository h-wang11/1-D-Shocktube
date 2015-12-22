      FUNCTION XQ(A,B)
      USE Global, ONLY: Tiny
      IMPLICIT NONE
C     XQ Limiter For 3rd-MUSCL
      REAL*8 :: A,B,C,N
      REAL*8 :: XQ

      N=2.0_8 

      C=(A+Tiny)/(B+Tiny)
      IF (C.LE.0) THEN
          XQ=0.0_8
      ELSE
          XQ=3.0*C**N/(1.0+2.0*C**N)
      END IF

      END FUNCTION XQ










