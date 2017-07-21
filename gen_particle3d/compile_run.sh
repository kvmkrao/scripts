gfortran -ffree-form -ffree-line-length-none  -fimplicit-none DESParticleGen.f
./a.out 
echo "generated particles for 2D doamin"
gfortran -ffree-form -ffree-line-length-none  -fimplicit-none gen3d.f
./a.out
