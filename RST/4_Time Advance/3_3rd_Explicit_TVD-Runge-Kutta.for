      SUBROUTINE  Third_Explicit_TVD_RK
      USE Global
      IMPLICIT NONE
      INTEGER :: I,IP
C     3rd-Explitic TVD_Runge-Kutta 时间推进



      Time=0.0_8
      CALL Get_dt                                     ! 根据初始解来确定统一时间步长

      DO WHILE (Time.LT.ETime)
      !DO Iter=1,100

C         Present Time
          Time=Time+dt
          WRITE(*,*)Time                              ! 当前计算步对应的时刻


C         第1级迭代
              CALL Re_Construct                       ! 重构
              CALL Get_All_Flux(Method)               ! 通量计算
              DO I=1,N
                  IP=I+1
                  F(:,I)=F1(:,I) - dt/dh*( G(:,IP)-G(:,I) )
              END DO
              CALL Update_RK                          ! 变量更新

              CALL BC                                 ! 边界条件

C         第2级迭代
              CALL Re_Construct    
              CALL Get_All_Flux(Method)   
              DO I=1,N
                  IP=I+1
                  F(:,I)=3.0/4.0*F0(:,I) + 1.0/4.0*F1(:,I) - 1.0/4.0*dt/dh*( G(:,IP)-G(:,I) )
              END DO
              CALL Update_RK                   
              CALL BC                               

C         第3级迭代
              CALL Re_Construct    
              CALL Get_All_Flux(Method)   
              DO I=1,N
                  IP=I+1
                  F(:,I)=1.0/3.0*F2(:,I) + 2.0/3.0*F1(:,I) - 2.0/3.0*dt/dh*( G(:,IP)-G(:,I) )
              END DO
              CALL Update_RK                   
              CALL BC                               

      END DO

      END SUBROUTINE  Third_Explicit_TVD_RK