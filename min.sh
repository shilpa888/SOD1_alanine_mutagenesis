#!/bin/sh
#PBS -N SOD_dimer
#PBS -P chemistry
#PBS -q low
#PBS -m bea
#PBS -M $USER@chemistry.iitd.ac.in
#PBS -l select=1:ngpus=1:ncpus=1:centos=skylake
#PBS -l walltime=2:00:00
#PBS -o stdout_file
#PBS -e stderr_file

cd $PBS_O_WORKDIR

############################################################ Subroutines: START  ############################################################
        for (( i=6; i>=2; i-- ))
        do
                j=`expr $i - 1`
                pmemd.cuda -O -i mini$j.in -p complex_wat.prmtop -c complex_wat$i.inpcrd -r complex_wat$j.inpcrd -o complex_restrain$j.out -ref complex_wat$i.inpcrd
        done
        pmemd.cuda -O -i min.in   -p complex_wat.prmtop -c complex_wat1.inpcrd -r complex_watmin.inpcrd -o complex_watmin.out
        ambpdb -aatm -p complex_wat.prmtop <complex_watmin.inpcrd> complex_refined.pdb


pmemd.cuda -O -i heat.in -o complex_heat.out -p complex_wat.prmtop -c complex_watmin.inpcrd -ref complex_watmin.inpcrd -r complex_heat.ncrst -x complex_heat.nc
cp complex_heat.ncrst complex_mini5.ncrst
for (( i=5; i>=1; i-- ))
      do
        j=`expr $i - 1`
pmemd.cuda -O -i eq$i.in -o complex_eq$i.out -p complex_wat.prmtop -c complex_mini$i.ncrst -ref complex_mini$i.ncrst -r complex_mini$j.ncrst -x complex_eq0$i.nc
      done
        pmemd.cuda -O -i eq05.in -o complex_eq05.out -p complex_wat.prmtop -c complex_mini0.ncrst -ref complex_mini0.ncrst -r complex_eq05.ncrst -x complex_eq05.nc
        pmemd.cuda -O -i md0.in -o complex_md0.out -p complex_wat.prmtop -c complex_eq05.ncrst -r complex_md0.ncrst -x complex_md0.nc

############################################################ MAIN SCRIPT BODY: END ########################################################
exit

