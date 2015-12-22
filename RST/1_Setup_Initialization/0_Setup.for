      SUBROUTINE Set_Up
      USE Chem
      USE Global
      IMPLICIT NONE
      INTEGER :: I
      
C     ============================Initialization============================
C     CHEMIKIN & Transport Initialization
      CALL CHEM_INIT
      CALL TRAN_INIT
C     Number of Species
      Ns=KK
      Ns1=Ns-1
C     Total Number of Conserved Variables
      NT= Ns + 3
      NT1=NT-1

C     Type of Re-Consturction [ 0=No Reconstruction, 1= 3rd-MUSCL + XQ_Limiter ]
      ReConstruct_TYPE= 0
C     Re-Constructed Variables [ 1= Primitive, 2= Conserved ]
      ReConstruct_PC= 1

C     Dt [ s ]
      dt=1.0E-7_8
C     Node Number
      N=400
      N1p=N+1;N3p=N+3;N1m=N-1
C     Allocate Memory
      ALLOCATE(    Q1(NT,-2:N3p) )
      ALLOCATE(     F(NT,-2:N3p), F0(NT,-2:N3p), F1(NT,-2:N3p),    F2(NT,-2:N3p) )
      ALLOCATE(    Gc(NT,-2:N3p), Gv(NT,-2:N3p), Gs(NT,-2:N3p) )
      ALLOCATE(       X( -2:N3p) )
      ALLOCATE(   Rho( 2,-2:N3p),  U( 2,-2:N3p),  P( 2,-2:N3p), Msf(2,Ns,-2:N3p) )     ! 1= Cell Left Face, 2= Cell Right Face
      ALLOCATE(      Tpt(-2:N3p) )
      ALLOCATE(   Mlw( Ns ) )   

C     ¡¾Names of Species¡¿
      CALL CKSYMS (CWORK,6,SPNAME,KERR)
C     Species Sequence => H2, O2, O, OH, H2O, H, HO2, H2O2, N2

C     ¡¾ Molecular Weights of Species¡¿ [ g/mol ]
      CALL CKWT (IWORK,RWORK,Mlw) 


C     End Time [ s ]
      ETime=1.E-3_8
C     Mesh Size [ cm ]
      Length=12.0_8
      dh=Length/N
C     Coordinates(Cell Center)
      DO I=-2,N3p
          X(I)=(I-0.5_8)*dh - 0.5_8*Length
      END DO

      END SUBROUTINE Set_Up