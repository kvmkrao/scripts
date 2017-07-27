rm -rf C*

module purge
module load cmake/3.4.3
module load gcc/4.9.3
module load cuda/8.0.61
module load openmpi/1.10.6/gcc/4.9.3/cuda/8.0.61
module load boost/1.62.0/openmpi/1.10.6/gcc/4.9.3/cuda/8.0.61
module load netcdf/4.4.1.1/openmpi/1.10.6/gcc/4.9.3/cuda/8.0.61
module load hdf5/1.10.0.p1/openmpi/1.10.6/gcc/4.9.3/cuda/8.0.61

export NVCC_WRAPPER_DEFAULT_COMPILER=/home/projects/x86-64-haswell/gcc/4.9.3/bin/g++
export OMPI_CXX=/home/vkkotte/Trilinos/src/packages/kokkos/config/nvcc_wrapper
export CUDA_LAUNCH_BLOCKING=1
export CUDA_MANAGED_FORCE_DEVICE_ALLOC=1

BOOSTDIR=$BOOST_ROOT
NETCDF=$NETCDF_ROOT
HDF5DIR=$HDF5_ROOT
BLAS=/home/vkkotte/Trilinos/Software/lapack/install/
LAPACK=/home/vkkotte/Trilinos/Software/lapack/install/
BUILD_DIR=/home/vkkotte/Trilinos/install

cmake -D CMAKE_INSTALL_PREFIX:PATH=$BUILD_DIR \
      -D CMAKE_BUILD_TYPE:STRING=RELEASE \
      -D CMAKE_C_COMPILER="mpicc" \
      -D CMAKE_CXX_COMPILER="mpicxx" \
      -D CMAKE_Fortran_COMPILER="mpif90" \
      -D BLAS_LIBRARY_NAMES:STRING="libblas.so.3" \
      -D BLAS_LIBRARY_DIRS:PATH=$BLAS/lib64 \
      -D BLAS_INCLUDE_DIRS:PATH=$BLAS/include \
      -D LAPACK_LIBRARY_NAMES:STRING="liblapack.so.3" \
      -D LAPACK_LIBRARY_DIRS:PATH=$LAPACK/lib64 \
\
      -D CMAKE_CXX_FLAGS="-std=c++11 --expt-extended-lambda -DKOKKOS_CUDA_USE_LAMBDA" \
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
      -D Trilinos_ENABLE_Intrepid=ON \
      -D Trilinos_ENABLE_TrilinosCouplings=ON \
      -D Trilinos_ENABLE_Sacado=ON \
      -D Trilinos_ENABLE_Intrepid2=ON \
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
\
      -D Trilinos_ENABLE_Amesos:BOOL=ON \
      -D Trilinos_ENABLE_Amesos2:BOOL=ON \
      -D Trilinos_ENABLE_EpetraExt:BOOL=ON \
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
      -D Kokkos_ENABLE_Cuda_Lambda:BOOL=ON \
      -D Trilinos_ENABLE_Intrepid2:BOOL=ON \
      -D HAVE_INTREPID_KOKKOSCORE:BOOL=ON \
/home/vkkotte/Trilinos/src

make -j16 KOKKOS_DEVICES=Cuda
make install

