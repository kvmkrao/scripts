# Early Nov 2014. Instructional Trilinos configuration script for Tpetra-enabled
#                 Albany.
# 18 Feb 2015.    Now updated for Kokkos-enabled Albany.

# Modify these paths for your system.
HOME=/work/04051/vkotteda/stampede2/Trilinos/tpl
INSTALLDIR=/work/04051/vkotteda/stampede2/trilinos_pthreads/install
BOOSTDIR=$HOME/boost/install
NETCDFDIR=$HOME/netcdf/install/
HDF5DIR=$HOME/hdf5/install/
LAPDIR=$HOME/lapack/install/lib64
MPIDIR=$HOME//mpi/install
PARMETISDIR=$HOME/Software/parmetis/install
MKL_ROOT=/opt/intel/mkl/lib/intel64_lin_mic
# Remove the CMake cache. For an extra clean start in an already-used build
# directory, rm -rf CMake* to get rid of all CMake-generated files.

rm -rf CMake* 


export NVCC_WRAPPER_DEFAULT_COMPILER=/opt/intel/compilers_and_libraries/linux/bin/intel64/icpc
export OMPI_CXX=/work/04051/vkotteda/stampede2/trilinos_3rd_openmp/build/nvcc_wrapper 
export ARCH_CXX_FLAG="-xMIC-AVX512 -mkl"
export ARCH_C_FLAG="-xMIC-AVX512 -mkl"

#  -D TPL_BLAS_LIBRARIES:FILEPATH="$LAPDIR/libblas.so.3" \
#  -D TPL_LAPACK_LIBRARIES:FILEPATH="$LAPDIR/liblapack.so.3" \

cmake \
 -D Trilinos_DISABLE_ENABLED_FORWARD_DEP_PACKAGES=ON \
 -D CMAKE_INSTALL_PREFIX:PATH=${INSTALLDIR} \
 -D CMAKE_BUILD_TYPE:STRING=RELEASE \
 -D BUILD_SHARED_LIBS:BOOL=OFF \
 -D TPL_ENABLE_MPI:BOOL=ON \
 -D Trilinos_ENABLE_OpenMP=OFF \
 -D Trilinos_ENABLE_Pthread=ON \
 -D Trilinos_ENABLE_Fortran:BOOL=ON \
 -D CMAKE_C_COMPILER="mpicc" \
 -D CMAKE_CXX_COMPILER="mpicxx" \
 -D CMAKE_Fortran_COMPILER="mpif90" \
 -D CMAKE_VERBOSE_MAKEFILE:BOOL=OFF \
 -D Trilinos_ENABLE_ALL_PACKAGES:BOOL=OFF \
 -D Trilinos_WARNINGS_AS_ERRORS_FLAGS:STRING="" \
 -D Teuchos_ENABLE_LONG_LONG_INT:BOOL=ON \
\
 -D Trilinos_ENABLE_Teuchos:BOOL=ON \
 -D Trilinos_ENABLE_Belos:BOOL=ON \
\
 -D TPL_ENABLE_Boost:BOOL=ON \
 -D Boost_INCLUDE_DIRS:FILEPATH="$BOOSTDIR/include" \
 -D Boost_LIBRARY_DIRS:FILEPATH="$BOOSTDIR/lib" \
 -D TPL_ENABLE_BoostLib:BOOL=ON \
 -D BoostLib_INCLUDE_DIRS:FILEPATH="$BOOSTDIR/include" \
 -D BoostLib_LIBRARY_DIRS:FILEPATH="$BOOSTDIR/lib" \
\
 -D TPL_ENABLE_Netcdf:BOOL=ON \
 -D Netcdf_INCLUDE_DIRS:PATH="$NETCDFDIR/include" \
 -D Netcdf_LIBRARY_DIRS:PATH="$NETCDFDIR/lib" \
\
 -D Trilinos_ENABLE_Epetra:BOOL=OFF \
 -D Trilinos_ENABLE_EpetraExt:BOOL=OFF \
 -D Trilinos_ENABLE_Tpetra:BOOL=ON \
 -D Trilinos_ENABLE_Kokkos:BOOL=ON \
 -D Trilinos_ENABLE_Ifpack2:BOOL=ON \
 -D Trilinos_ENABLE_Amesos2:BOOL=OFF \
 -D Trilinos_ENABLE_Zoltan2:BOOL=OFF \
 -D Trilinos_ENABLE_MueLu:BOOL=OFF \
 -D Amesos2_ENABLE_KLU2:BOOL=OFF \
  -D TPL_ENABLE_BLAS:BOOL=ON \
  -D TPL_ENABLE_LAPACK:BOOL=ON \
  -D TPL_BLAS_LIBRARIES:STRING="-L${MKLROOT} -lmkl_intel_lp64 -lmkl_blas95_lp64 -lmkl_core -lmkl_sequential" \
  -D TPL_LAPACK_LIBRARIES:STRING="-L${MKLROOT} -lmkl_lapack95_lp64" \
\
 -D Trilinos_ENABLE_EXPLICIT_INSTANTIATION:BOOL=ON \
 -D Tpetra_INST_INT_LONG_LONG:BOOL=ON \
 -D Tpetra_INST_INT_INT:BOOL=ON \
 -D Tpetra_INST_DOUBLE:BOOL=ON \
 -D Tpetra_INST_FLOAT:BOOL=OFF \
 -D Tpetra_INST_COMPLEX_FLOAT:BOOL=OFF \
 -D Tpetra_INST_COMPLEX_DOUBLE:BOOL=OFF \
 -D Tpetra_INST_INT_LONG:BOOL=OFF \
 -D Tpetra_INST_INT_UNSIGNED:BOOL=OFF \
 -D Tpetra_INST_OPENMP:BOOL=OFF \
 -D Tpetra_INST_PTHREAD:BOOL=ON \
\
 -D Trilinos_ENABLE_Kokkos:BOOL=ON \
 -D Trilinos_ENABLE_KokkosCore:BOOL=ON \
 -D Phalanx_KOKKOS_DEVICE_TYPE:STRING="SERIAL" \
 -D Phalanx_INDEX_SIZE_TYPE:STRING="INT" \
 -D Phalanx_SHOW_DEPRECATED_WARNINGS:BOOL=OFF \
 -D Kokkos_ENABLE_Serial:BOOL=OFF \
 -D Kokkos_ENABLE_OpenMP:BOOL=OFF \
  -D TPL_ENABLE_BLAS:BOOL=ON \
  -D TPL_ENABLE_LAPACK:BOOL=ON \
  -D CMAKE_C_FLAGS:STRING="--xMIC-AVX512  -lpthread -mkl" \
  -D CMAKE_CXX_FLAGS:STRING="-std=c++11 -O3 -xMIC-AVX512  -lpthread -mkl" \
  -D CMAKE_Fortran_FLAGS:STRING=" -O3  -xMIC-AVX512 -lpthread -mkl" \
  -D Trilinos_ENABLE_Fortran:BOOL=ON \
  -D Kokkos_ENABLE_Pthread:BOOL=ON \
  -D TPL_ENABLE_Pthread:BOOL=ON \
  -D Tpetra_INST_PTHREAD:BOOL=ON \
  -D Trilinos_EXTRA_LINK_FLAGS:STRING="-lmpi -ldl -lutil -lm -ldl -lpthread" \
/work/04051/vkotteda/stampede2/gitres

make -j16 
make install 
