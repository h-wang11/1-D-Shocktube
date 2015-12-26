      SUBROUTINE  Third_Explicit_TVD_RK
      USE Global
      IMPLICIT NONE
      INTEGER :: I,IP
C     3rd-Explitic TVD_Runge-Kutta 时间推进



      SELECT CASE(IF_Continue)
          CASE(0)
          Time=0.0_8
          Iter=0
      END SELECT

      DO WHILE (Time.LT.ETime)
      !DO Iter=1,1
      Iter=Iter+1

C         Present Time
          Time=Time+dt
          WRITE(*,*)Time                              ! 当前计算步对应的时刻


C         第1级迭代
              CALL Re_Construct                       ! 重构 ( For Convective Flux )
              CALL Get_All_Convective_Flux            ! 对流通量计算

              SELECT  CASE( IF_Transport )
                  CASE(1)
                      CALL Get_All_Transport_Coefs            ! 输运系数计算
                      CALL Get_All_Viscous_Flux               ! 粘性通量
              END SELECT
              SELECT CASE( IF_Reaction )
                  CASE(1)
                      CALL Get_All_Source                     ! 反应源项
              END SELECT

              DO I=1,N
                  IP=I+1
                  F(:,I)=F1(:,I) - dt/dh*( Gc(:,IP)-Gc(:,I) ) 
                  SELECT  CASE( IF_Transport )
                      CASE(1)
                          F(:,I) = F(:,I) + dt/dh*( Gv(:,IP)-Gv(:,I) )
                  END SELECT
                  SELECT CASE( IF_Reaction )
                      CASE(1)
                          F(:,I) = F(:,I) + dt*Gs(:,I) 
                  END SELECT
C     >                           + dt/dh*( Gv(:,IP)-Gv(:,I) ) 
C     >                           + dt*Gs(:,I)           
C                        此时F1 为 n 时刻变量, F 为一级中间变量
              END DO

              CALL Update_RK                          ! 变量更新

              CALL BC                                 ! 边界条件

C         第2级迭代
              CALL Re_Construct    
              CALL Get_All_Convective_Flux  

              SELECT  CASE( IF_Transport )
                  CASE(1)
                      CALL Get_All_Transport_Coefs            ! 输运系数计算
                      CALL Get_All_Viscous_Flux               ! 粘性通量
              END SELECT
              SELECT CASE( IF_Reaction )
                  CASE(1)
                      CALL Get_All_Source                     ! 反应源项
              END SELECT

              DO I=1,N
                  IP=I+1
                  F(:,I)=3.0/4.0*F0(:,I) + 1.0/4.0*F1(:,I) - 1.0/4.0*dt/dh*( Gc(:,IP)-Gc(:,I) )
                  SELECT  CASE( IF_Transport )
                      CASE(1)
                          F(:,I) = F(:,I) + 1.0/4.0*dt/dh*( Gv(:,IP)-Gv(:,I) ) 
                  END SELECT
                  SELECT CASE( IF_Reaction )
                      CASE(1)
                          F(:,I) = F(:,I) + 1.0/4.0*dt*Gs(:,I) 
                  END SELECT
C     >                                                     + 1.0/4.0*dt/dh*( Gv(:,IP)-Gv(:,I) ) 
C     >                                                     + 1.0/4.0*dt*Gs(:,I)   
C                                此时F0为 n 时刻变量, F1为一级中间变量, F 为二级中间变量 
              END DO
              CALL Update_RK                   
              CALL BC                               

C         第3级迭代
              CALL Re_Construct    
              CALL Get_All_Convective_Flux  

              SELECT  CASE( IF_Transport )
                  CASE(1)
                      CALL Get_All_Transport_Coefs            ! 输运系数计算
                      CALL Get_All_Viscous_Flux               ! 粘性通量
              END SELECT
              SELECT CASE( IF_Reaction )
                  CASE(1)
                      CALL Get_All_Source                     ! 反应源项
              END SELECT

              DO I=1,N
                  IP=I+1
                  F(:,I)=1.0/3.0*F2(:,I) + 2.0/3.0*F1(:,I) - 2.0/3.0*dt/dh*( Gc(:,IP)-Gc(:,I) )
                  SELECT  CASE( IF_Transport )
                      CASE(1)
                          F(:,I) = F(:,I) + 2.0/3.0*dt/dh*( Gv(:,IP)-Gv(:,I) ) 
                  END SELECT
                  SELECT CASE( IF_Reaction )
                      CASE(1)
                          F(:,I) = F(:,I) + 2.0/3.0*dt*Gs(:,I)
                  END SELECT
C     >                                                     + 2.0/3.0*dt/dh*( Gv(:,IP)-Gv(:,I) ) 
C     >                                                     + 2.0/3.0*dt*Gs(:,I)   
C                                此时F2为 n 时刻变量, F 为 n+1 时刻变量, F1 为二级中间变量 
              END DO
              CALL Update_RK                   
              CALL BC 

          IF ( MOD(Iter,OutD).EQ.0 ) THEN
              CALL Output_Ins
          END IF                              

      END DO

      END SUBROUTINE  Third_Explicit_TVD_RK