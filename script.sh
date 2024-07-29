#!/bin/bash

#export OMP_NUM_THREADS=14
cpptraj complex_wat.prmtop  << EOF

trajin dimer_md_complete_150_ai.nc 1 10000000 1

#center :1-310
#image :1-310

autoimage
center :1-310 mass origin
image origin center familiar 

trajout complex_md_all_nowat_noions.nc netcdf 
EOF

exit

