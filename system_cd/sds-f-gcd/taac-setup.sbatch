#!/bin/sh
#SBATCH -J gcd-sds        # Job name
#SBATCH -o gcd-sds.o%j    # Name of stdout output file
#SBATCH -e gcd-sds.e%j    # Name of stderr error file
#SBATCH -p rtx-dev              # Queue (partition) name
#SBATCH -N 1               # Total # of nodes (must be 1 for serial)
#SBATCH -n 16               # Total # of mpi tasks (should be 1 for serial)
#SBATCH -t 01:59:00        # Run time (hh:mm:ss)
#SBATCH --mail-type=all    # Send email at begin and end of job
#SBATCH -A DMS22011        # Project/Allocation name (req'd if you have more than 1)
#SBATCH --mail-user=maxtopel@uchicago.edu

module load cuda/11.3
module load gcc/9.1.0

#export PATH=/work2/03273/tg825722/shared-folder-siva/software/enhancements/plumed-2.8.1/installed-files/bin:$PATH
#export LIBRARY_PATH=/work2/03273/tg825722/shared-folder-siva/software/enhancements/plumed-2.8.1/installed-files/lib:$LIBRARY_PATH
#export LD_LIBRARY_PATH=/work2/03273/tg825722/shared-folder-siva/software/enhancements/plumed-2.8.1/installed-files/lib:$LD_LIBRARY_PATH
#export PLUMED_KERNEL=/work2/03273/tg825722/shared-folder-siva/software/enhancements/plumed-2.8.1/installed-files/lib/libplumedKernel.so

#echo PATH=/work2/03273/tg825722/shared-folder-siva/software/enhancements/openmpi/openmpi-2.0.2/installed-files/bin:$PATH
#echo LIBRARY_PATH=/work2/03273/tg825722/shared-folder-siva/software/enhancements/openmpi/openmpi-2.0.2/installed-files/lib:$PATH
#export LD_LIBRARY_PATH=/work2/03273/tg825722/shared-folder-siva/software/enhancements/openmpi/openmpi-2.0.2/installed-files/lib:$LD_LIBRARY_PATH

#source /work2/03273/tg825722/shared-folder-siva/software/gromacs/gromacs-2021.6/installed-files/bin/GMXRC
source load-gromacs.sh

#Set runtime path of "/home1/03273/tg825722/software/gromacs/gromacs-2021.6/installed-files/bin/gmx" to "$ORIGIN/../lib64:/opt/apps/cuda/11.3/lib64:/opt/apps/hwloc/1.11.13/lib"

#rm -f *# sys-prod-out.mdp COLVAR HILLS BIAS logfile step* bck* bcd-sds.* hills* *.cpt *.edr *.xtc *.log *.gro

# energy minimization
gmx grompp -f gcd-emin.mdp -c gcd.gro -p gcd.top -po gcd-out.mdp -o gcd.tpr -maxwarn 4 -r gcd.gro 

gmx mdrun -s gcd.tpr -deffnm gcd-emin

# equilibration
gmx grompp -f gcd-equil.mdp -c gcd-emin.gro -p gcd.top -po gcd-equil-out.mdp -o gcd-equil.tpr -maxwarn 4 -r gcd-emin.gro

gmx mdrun -s gcd-equil.tpr -deffnm gcd-equil

# NPT equilibration
gmx grompp -f gcd-equil-npt.mdp -c gcd-equil.gro -p gcd.top -po gcd-equil-npt-out.mdp -o gcd-equil-npt.tpr -maxwarn 4 -r gcd-equil.gro

gmx mdrun -s gcd-equil-npt.tpr -deffnm gcd-equil-npt


#take last frame as gcd gro
gmx trjconv -f  gcd-equil-npt.xtc -s  gcd-equil-npt.tpr -o gcd_frame.gro -b 1000.000000 -dump 1000.000000 <<EOF
0
EOF

#construct box-probe
./box-probes.sh
./restr.sh
#create system
./sys_one.sh


#Set runtime path of "/home1/03273/tg825722/software/gromacs/gromacs-2021.6/installed-files/bin/gmx" to "$ORIGIN/../lib64:/opt/apps/cuda/11.3/lib64:/opt/apps/hwloc/1.11.13/lib"

#minimize system
# energy minimization
gmx grompp -f gcd-emin.mdp -c sysv.gro -p sys.top -po sysv-out.mdp -o sysv.tpr -maxwarn 4 -r sysv.gro

gmx mdrun -s sysv.tpr -deffnm sysv-emin

# equilibration
gmx grompp -f gcd-equil.mdp -c sysv-emin.gro -p sys.top -po sysv-equil-out.mdp -o sysv-equil.tpr -maxwarn 4 -r sysv-emin.gro

gmx mdrun -s sysv-equil.tpr -deffnm sysv-equil

# NPT equilibration
gmx grompp -f gcd-equil-npt.mdp -c sysv-equil.gro -p sys.top -po sysv-equil-npt-out.mdp -o sysv-equil-npt.tpr -maxwarn 4 -r sysv-equil.gro

gmx mdrun -s sysv-equil-npt.tpr -deffnm sysv-equil-npt

gmx trjconv -f  sysv-equil-npt.xtc -s  sysv-equil-npt.tpr -o sys.gro -b 1000.000000 -dump 1000.000000 <<EOF
0
EOF

#neutralize system
./sys_two.sh



