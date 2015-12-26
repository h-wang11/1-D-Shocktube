      subroutine Get_All_Source
      
!     subroutine for preparation of source term calculation
!          
!     essential inputs:
!         Y(Ns)  -  mass fraction of each species
!         T      -  temperature of the reacting mixture
!         P      -  pressure of the reacting mixture
!     are based on conserved variables F(:,i) at N time step, node i, 
!         F(1,i)  -  rho    -  density
!         F(2,i)  -  rho*u  -  momentum
!         F(3,i)  -  rho*et -  total energy
!         F(4:Ns+3,i)  - rho*Yi  -  species concentration
      
      use Chem
      use Global, only: N, Ns, X0, F, Gs
      implicit none
C     割线法函数接口
      interface 
          function Secant( X0, a, Msf, F, Epsilon, MAX_Iter )
              use Chem
              use Global, only: Ns
              implicit none
              real*8 :: Secant  
              real*8 :: a             
              real*8 :: Msf(Ns)                
              real*8 :: X0(2)          
              real*8 :: Epsilon    
              integer :: MAX_Iter     
              real*8,external :: F       
          end function Secant
      end interface      
      
      real*8 :: rho, u, p, e, h, hh, temp
      real*8 :: y(Ns), dzdt(Ns)
      real*8,external :: E_to_T
      integer :: i
      
      do i=1,N
          rho  = F(1,i)
          u    = F(2,i)/rho
          e    = (F(3,i) -0.5*u**2)/rho
          y(1:Ns) = F(4:3+Ns,i)/rho
          temp = Secant( X0, e, y, E_to_T, 1.E-3_8, 100 )
          call ckhbms(temp, y, IWORK, RWORK, h)
          p    = rho*(h-e)
          
          call cidzdt(rho, temp, y, p, dzdt)
          Gs(1:3,i) = 0.0_8
          Gs(4:3+Ns,i) = dzdt(1:Ns)
      end do
      
      end subroutine Get_All_Source