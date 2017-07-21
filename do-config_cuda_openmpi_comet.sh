
module purge
module load cmake
module load gnutools
module load intel
module load cuda/8.0
export MODULEPATH=/share/apps/compute/modulefiles/mpi:$MODULEPATH
module load openmpi_ib/1.10.2_intel


tpl=/oasis/scratch/comet/vkotteda/temp_project/Software/trilinos_3rd/cuda_mpi/Software

export NVCC_WRAPPER_DEFAULT_COMPILER=/opt/gnu/gcc/bin/g++
export OMPI_CXX=/oasis/scratch/comet/vkotteda/temp_project/Software/trilinos_3rd/openmpi/trilinos/gitres/packages/kokkos/config/nvcc_wrapper
export CUDA_LAUNCH_BLOCKING=1
export CUDA_MANAGED_FORCE_DEVICE_ALLOC=1

BOOSTDIR=$tpl/boost/install
NETCDF=$tpl/netcdf/install 
HDF5DIR=$tpl/hdf5/install 
BLAS=$tpl/lapack/install
LAPACK=$tpl/lapack/install
BUILD_DIR=/oasis/scratch/comet/vkotteda/temp_project/Software/trilinos_3rd/cuda_mpi/install


cmake -D CMAKE_INSTALL_PREFIX:PATH=$BUILD_DIR \
      -D CMAKE_BUILD_TYPE:STRING=RELEASE \
      -D CMAKE_C_COMPILER=/share/apps/compute/mpi/openmpi/v1.10.2_intel/bin/mpicc  \
      -D CMAKE_CXX_COMPILER=/share/apps/compute/mpi/openmpi/v1.10.2_intel/bin/mpicxx \
      -D CMAKE_Fortran_COMPILE1=/share/apps/compute/mpi/openmpi/v1.10.2_intel/bin/mpif90 \
      -D BLAS_LIBRARY_NAMES:STRING="libblas.so.3" \
      -D BLAS_INCLUDE_DIRS:PATH=$BLAS/include \
      -D BLAS_LIBRARY_DIRS:PATH=$BLAS/lib64 \
      -D LAPACK_LIBRARY_NAMES:STRING="liblapack.so.3" \
      -D LAPACK_LIBRARY_DIRS:PATH=$LAPACK/lib64 \
\
      -D CMAKE_CXX_FLAGS="-std=c++11 --expt-extended-lambda  -DKOKKOS_CUDA_USE_LAMBDA" \
      -D Trilinos_ENABLE_EXPLICIT_INSTANTIATION:BOOL=ON \
      -D Trilinos_ENABLE_DEBUG:BOOL=OFF \
      -D Trilinos_ENABLE_INSTALL_CMAKE_CONFIG_FILES:BOOL=ON \
\
      -D TPL_ENABLE_MPI:BOOL=ON \
\
      -D TPL_ENABLE_Boost:BOOL=ON \
      -D TPL_ENABLE_BoostLib:BOOL=ON \
      -D Boost_INCLUDE_DIRS:FILEPATH=$BOOSTDIR/include \
      -D Boost_LIBRARY_DIRS:FILEPATH=$BOOSTDIR/lib \
      -D BoostLib_INCLUDE_DIRS:FILEPATH=$BOOSTDIR/include \
      -D BoostLib_LIBRARY_DIRS:FILEPATH=$BOOSTDIR/lib \
      -D TPL_ENABLE_HDF5:BOOL=ON \
      -D TPL_ENABLE_Netcdf:BOOL=ON \
      -D TPL_Netcdf_INCLUDE_DIRS:PATH=$NETCDF/include \
      -D Netcdf_LIBRARY_DIRS:PATH=$NETCDF/lib \
      -D HDF5_INCLUDE_DIRS:PATH=$HDF5DIR/include \
      -D HDF5_LIBRARY_DIRS:PATH=$HDF5DIR/lib \
      -D Trilinos_ASSERT_MISSING_PACKAGES:BOOL=OFF \
      -D Trilinos_ENABLE_ALL_OPTIONAL_PACKAGES:BOOL=OFF \
      -D Trilinos_ENABLE_ALL_PACKAGES:BOOL=OFF \
      -D Trilinos_ENABLE_EXAMPLES:BOOL=OFF \
      -D Trilinos_VERBOSE_CONFIGURE:BOOL=OFF \
      -D Trilinos_WARNINGS_AS_ERRORS_FLAGS:STRING="" \
\
      -D Trilinos_ENABLE_CXX11:BOOL=ON \
      -D Trilinos_ENABLE_Tpetra:BOOL=ON \
      -D Kokkos_ENABLE_Cuda:BOOL=ON \
      -D Kokkos_ENABLE_Cuda_UVM:BOOL=ON \
      -D Kokkos_ENABLE_EXAMPLES:BOOL=OFF \
      -D Kokkos_ENABLE_OpenMP:BOOL=OFF \
      -D Kokkos_ENABLE_Pthread:BOOL=OFF \
      -D Kokkos_ENABLE_TESTS:BOOL=ON \
      -D Kokkos_ENABLE_DEBUG:BOOL=ON \
      -D TPL_ENABLE_CUDA:BOOL=ON \
      -D TPL_ENABLE_CUSPARSE:BOOL=ON \
      -D TPL_ENABLE_Thrust:BOOL=ON \
\
      -D Trilinos_ENABLE_Amesos:BOOL=ON \
      -D Trilinos_ENABLE_Amesos2:BOOL=ON \
      -D Trilinos_ENABLE_EpetraExt:BOOL=ON \
      -D EpetraExt_USING_HDF5:BOOL=OFF \
      -D Trilinos_ENABLE_Epetra:BOOL=ON \
      -D Trilinos_ENABLE_Zoltan:BOOL=OFF \
      -D Trilinos_ENABLE_EXAMPLES:BOOL=OFF \
      -D Trilinos_ENABLE_Belos:BOOL=ON \
      -D Trilinos_ENABLE_Ifpack2:BOOL=ON \
      -D Trilinos_ENABLE_OpenMP:BOOL=OFF \
      -D Trilinos_ENABLE_MueLu:BOOL=ON \
      -D Trilinos_ENABLE_TESTS:BOOL=OFF \
      -D Trilinos_ENABLE_Teuchos:BOOL=ON \
      -D Teuchos_ENABLE_COMPLEX:BOOL=OFF \
      -D Tpetra_INST_CUDA:BOOL=ON \
/oasis/scratch/comet/vkotteda/temp_project/Software/trilinos_3rd/openmpi/trilinos/gitres 

#/oasis/scratch/comet/vkotteda/temp_project/Software/trilinos_3rd/openmpi/trilinos/master
#/oasis/scratch/comet/vkotteda/temp_project/Software/trilinos_3rd/tpl/trilinos/Trilinos12p8

make -j16 
make install
