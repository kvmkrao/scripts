!
!******************************************************************
!  DES input generator
!  Sample generator to generate particle positions and outputs in DES readable format
!  Please use this as a basis and perform any additional customizations as
!  needed and this module does not come with any guarantees
!
!  The particles generated by this code are greater than or equal to specified np and
!  MFIX will pick up the correct particles according to value of np specified in the code
!
!******************************************************************
!
!
	Program DES_Particle_Genrator
!	implicit real*8(a-h,o-z)
	integer maxp
	parameter (maxp = 99999) ! Static allocation

	integer dim
	integer random		! 1=random distribution; 0=alligned
        integer accept, touch, ia
 	integer i, j, k, iseed
        integer n, np, np1,npxy
	integer nx, ny, nz,npz

	real*8 xp, yp, zp, x(maxp), y(maxp), z(maxp),zn(9999)
	real*8 u, v, w,rad
        real*8 xl, yl, zl
        real*8 radius, dia, dist, rad1
        real*8 density

        open(unit=10, file="particle_input.dat", status='old')
        open(unit=11, file="Pgen.in", status='old')
        open(unit=20, file="particle_input3d.dat", status='replace')

	
	read (11,*) dim
	read (11,*) random
        read (11,*) np
        read (11,*) radius
        write (*,*)  "radius", radius
        read (11,*) density
        read (11,*) xl
        read (11,*) yl
        read (11,*) zl
        write (*,*) " zl" , zl

	dia  = 2.1*radius	! so that particles don't touch each other to begin with
        rad1 = 1.05*rad

	nx = xl/dia
	nz = ceiling(real(zl/dia))  !+ 1

	open(12,file="particles2d.txt",status='old') 
	read(12,*) npxy  

	write(*,*) " maximum particles can fit along the spanwise direction",  nz
	write(*,*) " Enter the number of particles < ", nz," along the spanwise direction"
	read *,npz


!        np1 = ceiling(real(np/nz))+ 1
!        ny = ceiling(real(np1/nx)) + 1

!!       Specifying the initial distribution of the particles
!	if(random.eq.0) then	! Ordered particle lattice
!           n = 1
!	   do k = 1, nz
!              zp = 0.5*dia + (k-1)*dia
!              do j = 1, ny
!                 yp = 0.5*dia + (j-1)*dia
!                 do i = 1, nx
!                    xp = 0.5*dia + (i-1)*dia
!                    x(n) = xp
!                    y(n) = yp
!                    z(n) = zp
!                    n = n+1
!                 end do
!              end do
!           end do
!        else if(random.eq.1) then
!           iseed = 98765432
!           call random_seed(iseed)
!	   do k = 1, nz
!              do i = 1, np1
! 10		 continue
!		 call random_particle(radius,xp,yp,zp,xl,yl,zl,dim)
!		 x(i) = xp
!		 y(i) = yp
!		 z(i) = zp
!		 dist = 0d0
!		 do j = 1, i
!		    if(j.ne.i) then
!		       dist = sqrt((x(i)-x(j))**2 + (y(i)-y(j))**2 +&
!		       (z(i)-z(j))**2)
!		       if(dist.le.dia) then
!			  go to 10
!		       end if
!		    end if
!		 end do
!              end do
!           end do
!        end if



!       setting the velocities to zero
	u = 0d0
	v = 0d0
	w = 0d0


           do i = 1, npxy
	      read(10,*) x(i), y(i), radius, density, u, v
!	      write(6,101) x(i), y(i), radius, density, u, v
           end do

	  write(*,*) " value nz", nz

	do k= 1, npz 
	   zn(k) =  dia + (k-1)* (zl-dia)/ npz
	   write(*,*) " Zn(",k," )", zn(k)
           do i = 1, npxy
	      write(20,201) x(i), y(i), zn(k), radius, density, u, v, w
           end do
	end do 

	 write(*,*) " No of particles in 3D domain is ", npz*npxy 
 101     FORMAT (6(1e10.4,2x))
 201     FORMAT (8(1e10.4,2x))

        stop
        end

!
!
!^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
! Random particle
!^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
!
        subroutine random_particle(rad, xp1, yp1, zp1, xl1, yl1, zl1, dim1)

        integer i, dim1, ic
        real*8 rad, xp1, yp1, zp1, xl1, yl1, zl1
        real*8 rad1
        real*8 pxy(3)

	   ic = 100000
           do i = 1, ic
             call random_number(pxy)
             xp1 = dble(pxy(1))*xl1
             yp1 = dble(pxy(2))*yl1
             zp1 = dble(pxy(3))*zl1
             rad1 = 1.05*rad
	     if(dim1.eq.2) zp1 = rad1
             rad1 = 1.05*rad
             if(dim1.eq.2) then
             if((xp1.ge.rad1).and.(xp1.le.xl1-rad1).and.(yp1.ge.rad1)&
		.and.(yp1.le.yl1-rad1)) exit
             else
             if((xp1.ge.rad1).and.(xp1.le.xl1-rad1).and.(yp1.ge.rad1)&
		.and.(yp1.le.yl1-rad1).and.(zp1.ge.rad1).and.&
		(zp1.le.zl1-rad1)) exit
             end if
           end do
           if(i.gt.ic) then
             print *,'not able to place particle'
	     stop
	   end if

        return
        end subroutine random_particle

!