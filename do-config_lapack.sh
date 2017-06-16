rm -rf CMakeFiles CMakeCache.txt
CC=mpicc;
CXX=mpicxx;
FC=mpif90;
FF=mpif77;

cmake \
 -DCMAKE_INSTALL_PREFIX:PATH=$1 \
 -DCMAKE_BUILD_TYPE=RELEASE \
 -DBUILD_SHARED_LIBS=ON \
 -D CMAKE_VERBOSE_MAKEFILE:BOOL=TRUE \
 -DLAPACKE=ON \
 -DBUILD_DEPRECATED:BOOL=ON \
$2

