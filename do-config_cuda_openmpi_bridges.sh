
#module purge
module load cmake
#module load gcc/5.3.0
module load gcc/4.8.4
module load mpi/gcc_openmpi
module load cuda/8.0
#module load cuda/8.0RC

export NVCC_WRAPPER_DEFAULT_COMPILER=/opt/packages/gcc/4.8.4/bin/g++
export OMPI_CXX=/pylon2/ac4s8rp/kotteda/cuda/Software/Trilinos/gitsrc/packages/kokkos/config/nvcc_wrapper
#export ARCH_CXX_FLAG="-mcpu=power8 -arch=sm_60"
#export ARCH_CXX_FLAG="-mcpu=power8 "
#export ARCH_C_FLAG="-mcpu=power8"
#export OMPI_CXX=/oasis/scratch/comet/vkotteda/temp_project/Software/trilinos_3rd/openmpi/trilinos/master/packages/kokkos/config/nvcc_wrapper

export CUDA_LAUNCH_BLOCKING=1
export CUDA_MANAGED_FORCE_DEVICE_ALLOC=1

CUDA=ON

HOME=/pylon2/ac4s8rp/kotteda/cuda/
HOME1=/pylon2/ac4s8rp/kotteda/cuda-gcc

BOOSTDIR=$HOME1/Software/boost/install
NETCDFDIR=$HOME1/Software/netcdf/install/
HDF5DIR=$HOME1/Software/hdf5/install/
LAPDIR=$HOME/Software/lapack/install
BLAS=$HOME/Software/lapack/install
LAPACK=$HOME/Software/lapack/install


cmake -D CMAKE_INSTALL_PREFIX:PATH=/pylon2/ac4s8rp/kotteda/cuda-gcc/install \
      -D CMAKE_BUILD_TYPE:STRING=RELEASE \
      -D CMAKE_C_COMPILER="mpicc" \
      -D CMAKE_CXX_COMPILER="mpicxx" \
      -D CMAKE_Fortran_COMPILER="mpif90" \
      -D BLAS_LIBRARY_NAMES:STRING="libblas.so.3" \
      -D BLAS_INCLUDE_DIRS:PATH=$BLAS/include \
      -D BLAS_LIBRARY_DIRS:PATH=$BLAS/lib64 \
      -D LAPACK_LIBRARY_NAMES:STRING="liblapack.so.3" \
      -D LAPACK_LIBRARY_DIRS:PATH=$LAPACK/lib64 \
      -D CMAKE_CXX_FLAGS="-std=c++11 --expt-extended-lambda  -DKOKKOS_CUDA_USE_LAMBDA" \
\
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
      -D HDF5_INCLUDE_DIRS:PATH=$HDF5DIR/include \
      -D HDF5_LIBRARY_DIRS:PATH=$HDF5DIR/lib \
      -D TPL_ENABLE_Netcdf:BOOL=ON \
      -D TPL_Netcdf_INCLUDE_DIRS:PATH=$NETCDFDIR/include \
      -D Netcdf_LIBRARY_DIRS:PATH=$NETCDFDIR/lib \
      -D Trilinos_ASSERT_MISSING_PACKAGES:BOOL=OFF \
      -D Trilinos_ENABLE_ALL_OPTIONAL_PACKAGES:BOOL=OFF \
      -D Trilinos_ENABLE_ALL_PACKAGES:BOOL=OFF \
      -D Trilinos_ENABLE_EXAMPLES:BOOL=OFF \
      -D Trilinos_VERBOSE_CONFIGURE:BOOL=OFF \
      -D Trilinos_WARNINGS_AS_ERRORS_FLAGS:STRING="" \
\
      -D Trilinos_ENABLE_CXX11:BOOL=ON \
      -D Trilinos_ENABLE_Tpetra:BOOL=ON \
      -D Trilinos_ENABLE_Amesos:BOOL=OFF \
      -D Trilinos_ENABLE_Amesos2:BOOL=OFF \
      -D Trilinos_ENABLE_EpetraExt:BOOL=OFF \
      -D Trilinos_ENABLE_Epetra:BOOL=OFF \
      -D EpetraExt_USING_HDF5:BOOL=OFF \
      -D Trilinos_ENABLE_Zoltan:BOOL=OFF \
      -D Trilinos_ENABLE_EXAMPLES:BOOL=OFF \
      -D Trilinos_ENABLE_Belos:BOOL=ON \
      -D Trilinos_ENABLE_Ifpack2:BOOL=ON \
      -D Trilinos_ENABLE_MueLu:BOOL=ON \
      -D Trilinos_ENABLE_TESTS:BOOL=OFF \
      -D Trilinos_ENABLE_Teuchos:BOOL=ON \
      -D Teuchos_ENABLE_COMPLEX:BOOL=OFF \
      -D Tpetra_INST_DOUBLE:BOOL=ON \
\
      -D Trilinos_ENABLE_OpenMP:BOOL=OFF \
      -D Tpetra_INST_CUDA:BOOL=${CUDA} \
      -D TPL_ENABLE_CUDA:BOOL=${CUDA} \
      -D TPL_ENABLE_CUSPARSE:BOOL=${CUDA} \
      -D Kokkos_ENABLE_Cuda:BOOL=${CUDA} \
      -D Kokkos_ENABLE_Cuda_UVM:BOOL=${CUDA} \
      -D Kokkos_ENABLE_OpenMP:BOOL=OFF \
      -D Kokkos_ENABLE_Pthread:BOOL=OFF \
      -D MPI_DEBUG_CUDA:BOOL=${CUDA} \
/pylon2/ac4s8rp/kotteda/cuda/Software/Trilinos/gitsrc

make -j16 
make install
