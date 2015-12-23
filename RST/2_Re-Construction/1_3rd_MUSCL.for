      SUBROUTINE MUSCL_3rd_P(I,UL,UR)
      USE Global
      IMPLICIT NONE
      INTEGER :: I,IM,IP,K
      REAL*8 :: DL(12),DR(12),G0,Sign
      REAL*8 :: UL(12),UR(12)
      REAL*8,EXTERNAL :: XQ
C     Primitive Variables Re-Construction
C     3rd-MUSCL
C                 NOTEs:
C                       Since the Mass Fraction of last species—N2 can be determined by those of other species
C                       The Last Primitive Variable-Y(Ns) won't be Re-constructed
      IM=I-1
      IP=I+1

C     格心左侧
      DL(:)=  Q1(:, I)-Q1(:,IM)     
      DR(:)=  Q1(:,IP)-Q1(:,I )

      DO K=1,NT1
          Sign=( DL(K)+Tiny )/( DR(K) + Tiny )
          IF (Sign.LE.0) THEN
              Sign=0.0_8
          ELSE
              Sign=1.0_8
          END IF

          G0=XQ(DR(K),DL(K))
          UL(K)=Q1(K,I) - Sign*( (3.0-2.0*G0)/6.0*DR(K) + G0/3.0*DL(K) )
      END DO

C=====================================================================

C     格心右侧
      DO K=1,NT1
          Sign=( DL(K)+Tiny )/( DR(K) + Tiny )
          IF (Sign.LE.0) THEN
              Sign=0.0_8
          ELSE
              Sign=1.0_8
          END IF

          G0=XQ(DL(K),DR(K))
          UR(K)=Q1(K,I) + Sign*( (3.0-2.0*G0)/6.0*DL(K) + G0/3.0*DR(K) )

      END DO

      END SUBROUTINE MUSCL_3rd_P
C===============================================================================================
C===============================================================================================


C===============================================================================================
C===============================================================================================
      SUBROUTINE MUSCL_3rd_C(I,UL,UR)
      USE Global
      IMPLICIT NONE
      INTEGER :: I,IM,IP,K
      REAL*8 :: DL(12),DR(12),G0,Sign
      REAL*8 :: UL(12),UR(12)
      REAL*8,EXTERNAL :: XQ
C     Conserved Variables Re-Construction
C     3rd-MUSCL
C                 NOTEs:
C                       Since the Mass Fraction of last species—N2 can be determined by those of other species
C                       The Last Primitive Variable-Y(Ns) won't be Re-constructed

      IM=I-1
      IP=I+1

C     格心左侧
      DL(:)=  F1(:, I)-F1(:,IM)     
      DR(:)=  F1(:,IP)-F1(:,I )
      DO K=1,NT1
          Sign=( DL(K)+Tiny )/( DR(K) + Tiny )
          IF (Sign.LE.0) THEN
              Sign=0.0_8
          ELSE
              Sign=1.0_8
          END IF

          G0=XQ(DR(K),DL(K))
          UL(K)=F1(K,I) - Sign*( (3.0-2.0*G0)/6.0*DR(K) + G0/3.0*DL(K) )

      END DO
C=====================================================================

C     格心右侧
      DO K=1,NT1
          Sign=( DL(K)+Tiny )/( DR(K) + Tiny )
          IF (Sign.LE.0) THEN
              Sign=0.0_8
          ELSE
              Sign=1.0_8
          END IF

          G0=XQ(DL(K),DR(K))
          UR(K)=F1(K,I) + Sign*( (3.0-2.0*G0)/6.0*DL(K) + G0/3.0*DR(K) )

      END DO

      END SUBROUTINE MUSCL_3rd_C
C===============================================================================================
C===============================================================================================
