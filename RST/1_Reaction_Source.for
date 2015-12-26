      subroutine cidzdt(rho, temp, y, p, dydt)
!     subroutien to calculate chemical reaction rate
!     inputs: 
!         rho  - density of mixture
!         temp - temperature of mixture
!         y    - mass fraction of species
!         p    - pressure of mixture
!     output
!         dydt - chemical reaction rate of each species
! 
!     
      use Chem
      use Global, only: Ns
      implicit none
      
      real*8, intent(in) :: rho, temp, y(Ns), p
      real*8, intent(out):: dydt(Ns)
      integer :: is
      
      call CKWYPK(p, temp, y, iwork, rwork, dydt)
      
	do is = 1, Ns
          if( y(is) <= 0.d0 ) dydt(is) = max( dydt(is), 0.0_8 )
          dydt(is) = dydt(is) / rho
	end do
      
      end subroutine cidzdt