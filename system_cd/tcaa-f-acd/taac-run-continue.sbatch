#!/bin/sh
# email on start, end, and abortion
#SBATCH --job-name=TCAA-acd-c
##SBATCH --output=out.out
#SBATCH --mail-type=END,FAIL
#SBATCH --mail-user=maxtopel@uchicago.edu
#SBATCH --partition=gm4-pmext #fela-cpu
#SBATCH --qos=gm4
#SBATCH --account=pi-andrewferguson
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --gres=gpu:1
#SBATCH --cpus-per-task=20
#SBATCH --time=30:00:00
##SBATCH --exclude=midway2-0661

module load gcc/6.2
module load openmpi/2.0.2
module load cmake
module load eigen/3.2
module load gsl
module load cuda/9.2
module load python/anaconda-2020.02
source activate gaussian
#
source /project2/andrewferguson/sivadasetty/software/gromacs/gromacs-2018.6/installed-files/bin/GMXRC
source /project2/andrewferguson/sivadasetty/software/scripts/plumed2.5.2-alltools.sh


#export PATH=/work2/03273/tg825722/shared-folder-siva/software/enhancements/plumed-2.8.1/installed-files/bin:$PATH
#export LIBRARY_PATH=/work2/03273/tg825722/shared-folder-siva/software/enhancements/plumed-2.8.1/installed-files/lib:$LIBRARY_PATH 
#export LD_LIBRARY_PATH=/work2/03273/tg825722/shared-fo

#Set runtime path of "/home1/03273/tg825722/software/gromacs/gromacs-2021.6/installed-files/bin/gmx" to "$ORIGIN/../lib64:/opt/apps/cuda/11.3/lib64:/opt/apps/hwloc/1.11.13/lib"

#rm -f *# sys-prod.xtc sys-prod-out.mdp sys-prod.log sys-prod.edr COLVAR HILLS BIAS logfile step*
#gmx grompp -f prod.mdp -c  sys-equil.gro -p sys.top -po sys-prod-out.mdp -o sys-prod.tpr -maxwarn 2 -r sys-neutral.gro

#gmx mdrun -s sys-prod.tpr -deffnm sys-prod

#NTASKS=$(($SLURM_NTASKS_PER_NODE * $SLURM_JOB_NUM_NODES))
OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
export PLUMED_NUM_THREADS=$OMP_NUM_THREADS
#mpirun -np $NTASKS --oversubscribe 

#export OMP_NUM_THREADS=16
gmx mdrun -ntomp $OMP_NUM_THREADS -pin on -s sys-prod.tpr -deffnm sys-prod -nice 1 -plumed plumed.dat -cpi sys-prod.cpt

#mpirun -np $NTASKS --oversubscribe gmx mdrun -ntomp $OMP_NUM_THREADS -pin on -plumed plumed.dat -s sys-prod.tpr -deffnm sys-prod -nice 1 -cpi sys-prod.cpt

