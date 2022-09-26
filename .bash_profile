module purge
module load ncl
module load ncview
module load cmake/3.21.4
module load intel-oneapi-compilers/2021.4.0
module load openmpi/4.1.1
module load netcdf-c/4.8.1 netcdf-fortran/4.5.3
module load parallel-netcdf/1.12.2
module load hdf5
module load perl

# Environment for WRF and WPS
#export NETCDF="/uufs/chpc.utah.edu/sys/spack/linux-rocky8-nehalem/intel-2021.4.0/netcdf"
#export PATH="$NETCDF:$PATH"
#export LD_LIBRARY_PATH="$NETCDF/lib:$LD_LIBRARY_PATH"
#export HDF5="$HDF5_ROOT"
#export PATH="$HDF5:$PATH"
#export LD_LIBRARY_PATH="$HDF5/lib:$LD_LIBRARY_PATH"

export J="-j 8"
export WRF_EM_CORE="1"
export WRFIO_NCD_LARGE_FILE_SUPPORT="1"
export DIR="/uufs/chpc.utah.edu/common/home/zpu-group16/cfeng/LIBRARIES"
export JASPERLIB="$DIR/grib2/lib"
export JASPERINC="$DIR/grib2/include"

# Environment for WRFPLUS, RTTOV, WRFDA, and DART
export NETCDF="/uufs/chpc.utah.edu/sys/spack/linux-rocky8-nehalem/intel-2021.4.0/netcdf-ompi"
export PATH="$NETCDF:$PATH"
export LD_LIBRARY_PATH="$NETCDF/lib:$LD_LIBRARY_PATH"
export HDF5="$HDF5_ROOT"
export PATH="$HDF5:$PATH"
export LD_LIBRARY_PATH="$HDF5/lib:$LD_LIBRARY_PATH"

export WRFPLUS_DIR="/uufs/chpc.utah.edu/common/home/zpu-group16/cfeng/DART/softwares/WRFPLUS"
export RTTOV="/uufs/chpc.utah.edu/common/home/zpu-group16/cfeng/DART/softwares/rttov_12.1"

# Set an environment variable *DART_DIR* to point to your base DART directory.
export DART_DIR="/uufs/chpc.utah.edu/common/home/zpu-group16/cfeng/DART"
