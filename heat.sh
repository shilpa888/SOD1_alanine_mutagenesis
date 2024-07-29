#!/bin/bash
#PBS -S /bin/bash
#PBS -N 1SOD
#PBS -P chemistry
#PBS -q low
#PBS -m bea
#PBS -M $USER@chemistry.iitd.ac.in
#PBS -l select=1:ncpus=1:ngpus=1:mpiprocs=1:centos=skylake
#PBS -l walltime=4:00:00
#PBS -o out
#PBS -e err

cd $PBS_O_WORKDIR

pmemd -O -i heat.in -o complex_heat.out -p sod_myr2.prmtop -c complex_watmin.inpcrd -ref complex_watmin.inpcrd -r complex_heat.ncrst -x complex_heat.nc

exit
