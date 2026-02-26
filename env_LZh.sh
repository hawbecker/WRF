#!/bin/bash -l
module --force purge
module load ncarenv/23.09 intel-classic/2023.2.1 craype/2.7.23 cray-mpich/8.1.27 hdf5/1.12.2 netcdf/4.9.2 parallel-netcdf/1.12.3 udunits/2.2.28 ncview/2.1.9 ncarcompilers/1.0.0
