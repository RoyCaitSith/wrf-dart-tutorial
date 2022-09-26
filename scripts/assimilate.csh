#!/bin/csh
#
# DART software - Copyright UCAR. This open source software is provided
# by UCAR, "as is", without charge, subject to all terms of use at
# http://www.image.ucar.edu/DAReS/DART/DART_download

# datea and paramfile are command-line arguments - OR -
# are set by a string editor (sed) command.

set datea     = ${1}
set paramfile = ${2}

source $paramfile

set start_time = `date +%s`
echo "host is " `hostname`

cd ${RUN_DIR}
echo $start_time >& ${RUN_DIR}/filter_started

# Make sure the previous results are not hanging around
if ( -e ${RUN_DIR}/obs_seq.final )  ${REMOVE} ${RUN_DIR}/obs_seq.final
if ( -e ${RUN_DIR}/filter_done   )  ${REMOVE} ${RUN_DIR}/filter_done

#  run data assimilation system
if ( $SUPER_PLATFORM == 'yellowstone' ) then

   setenv TARGET_CPU_LIST -1
   setenv FORT_BUFFERED true
   mpirun.lsf ./filter || exit 1

else if ( $SUPER_PLATFORM == 'cheyenne' ) then

# TJH MPI_SHEPHERD TRUE may be a very bad thing
   setenv MPI_SHEPHERD FALSE

   setenv TMPDIR  /dev/shm
   limit stacksize unlimited
   mpiexec_mpt dplace -s 1 ./filter || exit 1

else if ( $SUPER_PLATFORM == 'kingspeak' ) then

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
		
	 setenv MPI_SHEPHERD FALSE

	 set NETCDF = "/uufs/chpc.utah.edu/sys/spack/linux-rocky8-nehalem/intel-2021.4.0/netcdf-ompi"
	 set PATH = ($PATH $NETCDF)
	 set LD_BIRARY_PATH = ($LD_LIBRARY_PATH $NETCDF/lib)
	 set HDF5 = "$HDF5_ROOT"
	 set PATH = ($PATH $HDF5)
	 set LD_LIBRARY_PATH = ($LD_LIBRARY_PATH $HDF5/lib)
      
    echo $start_time >& ${RUN_DIR}/filter_started
    mpirun -np $SLURM_NTASKS ./filter || exit 1

endif

if ( -e ${RUN_DIR}/obs_seq.final )  touch ${RUN_DIR}/filter_done

set end_time = `date  +%s`
@ length_time = $end_time - $start_time
echo "duration = $length_time"

exit 0
