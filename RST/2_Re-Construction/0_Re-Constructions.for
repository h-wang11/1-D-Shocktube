      SUBROUTINE Re_Construct
      USE Global
      IMPLICIT NONE
      REAL*8 :: UL(12),UR(12)
      INTEGER :: I,IP,NsI

      DO I=0,N1p

          IP=I+1
             
          SELECT CASE(ReConstruct_TYPE)
              CASE(0)
C             不重构 （或者认为是零阶重构）
C                 格心左侧
                  UL(:)=Q1(:,I)
C                 格心右侧
                  UR(:)=Q1(:,I)
                    
              CASE(1)
C             3rd-MUSCL 
                  SELECT CASE(ReConstruct_PC)
                      CASE(1)
C                     Primitive Variables           
                          CALL MUSCL_3rd_P( I,UL(:),UR(:) )
                      CASE(2)
C                     Conserved Variables
                          CALL MUSCL_3rd_C( I,UL(:),UR(:) )

                  END SELECT

          END SELECT 

C=============================================================================================


          SELECT CASE( ReConstruct_PC )
              CASE(1)
C             Primitive Variables
C                 格心左侧
                  Rho(1,I)=UL(1)
                  U(1,I)=UL(2)
                  P(1,I)=UL(3)
C                 格心右侧
                  Rho(2,I)=UR(1)
                  U(2,I)=UR(2)
                  P(2,I)=UR(3)

C                 Mass Fraction
                  DO NsI=1,Ns
                      Msf(1,NsI,I)=UL(3+NsI)   ! Cell Left Face
                      Msf(2,NsI,I)=UR(3+NsI)   ! Cell Right Face
                  END DO

              CASE(2)
C             2=Conserved Variables 
C                 格心左侧
                  Rho(1,I)=UL(1)
                  U(1,I)=UL(2)/UL(1)
                  !P(1,I)=( UL(3)-0.5*Rho(1,I)*U(1,I)**2 )*(Gamma-1.0)  ! From rho*et => p, needs Enthalpy of each species  ,actually Newton Iteration => solve temperature

C                 格心右侧
                  Rho(2,I)=UR(1)
                  U(2,I)=UR(2)/UR(1)
                  !P(2,I)=( UR(3)-0.5*Rho(2,I)*U(2,I)**2 )*(Gamma-1.0)

C                 Mass Fraction
                  DO NsI=1,Ns
                      Msf(1,NsI,I)=UL(3+NsI)/UL(1)
                      Msf(2,NsI,I)=UR(3+NsI)/UR(1)  
                  END DO

          END SELECT


      END DO

      END SUBROUTINE Re_Construct











