#!/bin/sh
#SBATCH -J acd-pfos-EXP-restart         # Job name
#SBATCH -o acd-pfos-EXP.o%j    # Name of stdout output file
#SBATCH -e acd-pfos-EXP.e%j    # Name of stderr error file
#SBATCH -p rtx	            # Queue (partition) name
#SBATCH -N 1               # Total # of nodes (must be 1 for serial)
#SBATCH -n 16               # Total # of mpi tasks (should be 1 for serial)
#SBATCH -t 30:00:00        # Run time (hh:mm:ss)
#SBATCH --mail-type=all    # Send email at begin and end of job
#SBATCH -A DMS22011        # Project/Allocation name (req'd if you have more than 1)
#SBATCH --mail-user=maxtopel@uchicago.edu

module load cuda/11.3
module load gcc/9.1.0

export PATH=/work2/03273/tg825722/shared-folder-siva/software/enhancements/plumed-2.8.1/installed-files/bin:$PATH
export LIBRARY_PATH=/work2/03273/tg825722/shared-folder-siva/software/enhancements/plumed-2.8.1/installed-files/lib:$LIBRARY_PATH 
export LD_LIBRARY_PATH=/work2/03273/tg825722/shared-folder-siva/software/enhancements/plumed-2.8.1/installed-files/lib:$LD_LIBRARY_PATH                
export PLUMED_KERNEL=/work2/03273/tg825722/shared-folder-siva/software/enhancements/plumed-2.8.1/installed-files/lib/libplumedKernel.so

echo PATH=/work2/03273/tg825722/shared-folder-siva/software/enhancements/openmpi/openmpi-2.0.2/installed-files/bin:$PATH
echo LIBRARY_PATH=/work2/03273/tg825722/shared-folder-siva/software/enhancements/openmpi/openmpi-2.0.2/installed-files/lib:$PATH
export LD_LIBRARY_PATH=/work2/03273/tg825722/shared-folder-siva/software/enhancements/openmpi/openmpi-2.0.2/installed-files/lib:$LD_LIBRARY_PATH

source /work2/03273/tg825722/shared-folder-siva/software/gromacs/gromacs-2021.6/installed-files/bin/GMXRC

#Set runtime path of "/home1/03273/tg825722/software/gromacs/gromacs-2021.6/installed-files/bin/gmx" to "$ORIGIN/../lib64:/opt/apps/cuda/11.3/lib64:/opt/apps/hwloc/1.11.13/lib"

#rm -f *# sys-prod.xtc sys-prod-out.mdp sys-prod.log sys-prod.edr COLVAR HILLS BIAS logfile step*
#gmx grompp -f prod.mdp -c  sys-equil.gro -p sys.top -po sys-prod-out.mdp -o sys-prod.tpr -maxwarn 2 -r sys-neutral.gro

#gmx mdrun -s sys-prod.tpr -deffnm sys-prod

#NTASKS=$(($SLURM_NTASKS_PER_NODE * $SLURM_JOB_NUM_NODES))
#OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
#export PLUMED_NUM_THREADS=$OMP_NUM_THREADS
#mpirun -np $NTASKS --oversubscribe 

export OMP_NUM_THREADS=16
gmx mdrun -ntomp $OMP_NUM_THREADS -pin on -s sys-prod.tpr -deffnm sys-prod -nice 1 -plumed plumed.dat -cpi sys-prod.cpt

#mpirun -np $NTASKS --oversubscribe gmx mdrun -ntomp $OMP_NUM_THREADS -pin on -plumed plumed.dat -s sys-prod.tpr -deffnm sys-prod -nice 1 -cpi sys-prod.cpt

