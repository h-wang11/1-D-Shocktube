      PROGRAM MAIN
      USE Global
      IMPLICIT NONE

      CALL Set_Up                                 ! 设置控制参数

      CALL Initial                                ! 初始化流场

      CALL TIME_Advance                           ! 时间推进

      CALL Output                                 ! 输出流场
      
      WRITE(*,*) 'Finished'
      PAUSE

      END PROGRAM
