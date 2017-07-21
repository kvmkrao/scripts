!
!******************************************************************
!
!  DES input generator
!  Sample generator to generate particle positions and outputs in DES readable format
!  Please use this as a basis and perform any additional customizations as
!  needed and this module does not come with any guarantees
!
!  The particles generated by this code are greater than or equal to specified np and
!  MFIX will pick up the correct particles according to value of np specified in the code
!
!  TO DO:
!  1) Fix so that only np particle information is created
!  2) In MFIX read the entire input file and if the number of particles does not correspond to
!     the input deck, than flag an error.
!
!  Author: Jay Boyalakuntla  (May-12-06)
! Modified: S. Pannala (Nov-21-06)
!
!******************************************************************
!
!
	Program DES_Particle_Genrator

	integer maxp
	parameter (maxp = 20000) ! Static allocation

	integer dim
	integer random		! 1=random distribution; 0=alligned
        integer accept, touch, ia
 	integer i, j, k, iseed
        integer n, np, np1
	integer nx, ny, nz
	integer npx, npy 
	real*8 dx, dy 

	real*8 xp, yp, zp, x(maxp), y(maxp), z(maxp)
	real*8 u, v, w
        real*8 xl, yl, zl
        real*8 radius, dia, dist, rad1,rad
        real*8 density

        open(unit=10, file="Pgen.in", status='old')
        open(unit=20, file="particle_input.dat", status='replace')

	read (10,*) dim
	read (10,*) random
        read (10,*) np
        read (10,*) radius
        read (10,*) density
        read (10,*) xl
        read (10,*) yl
        read (10,*) zl

	dia = 2.1*radius	! so that particles don't touch each other to begin with
        rad1 = 1.05*rad

	nx = xl/dia
	ny = (yl/2.0)/dia 

!	nz = ceiling(real(zl/dia)) + 1
!        if(dim.eq.2) nz = 1
!        np1 = ceiling(real(np/nz))+ 1
!        ny = ceiling(real(np1/nx)) + 1

	write(*,*) "max nx, ny", nx, ny

	write(*,*) "enter no of particles in x and y -directions"
	read*, npx, npy 

	dx = (xl-dia)/npx
	dy = (yl-dia)/(2.0*npy) 
!       Specifying the initial distribution of the particles

        u = 0d0
        v = 0d0
        w = 0d0

	if(dim.eq.2) then 

	do i= 1, npy 
		do j=1,npx 
		xp = 0.5*dia + (j-1)*dx 
		yp = 2.0*dia + (i-1)*dy 
		write(20,11) xp, yp, radius, density, u, v
		end do 
	end do 
	else 
	write(*,*) "Sorry, particles for 3D geometry is not implemented"
	end if


        open(21,file="particles2d.txt",status='unknown')
        write(21,*) npx*npy
	close(21) 

	write(*,*) "No of particles ", (npx*npy) 

 11     FORMAT (6(1e10.4,2x))
 12     FORMAT (8(1e10.4,2x))

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