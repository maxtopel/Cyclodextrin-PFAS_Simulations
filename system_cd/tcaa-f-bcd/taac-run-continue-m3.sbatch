#!/bin/sh
# email on start, end, and abortion
#SBATCH --job-name=TCAA-bcd-i
##SBATCH --output=out.out
#SBATCH --mail-type=END,FAIL
#SBATCH --mail-user=maxtopel@uchicago.edu
#SBATCH --partition=gpu #andrewferguson-gpu
#SBATCH --account=pi-andrewferguson
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --gres=gpu:1
#SBATCH --cpus-per-task=20
#SBATCH --time=30:00:00
shopt -s expand_aliases
source ~/.bashrc
prepgmx
export PATH="/project2/andrewferguson/maxtopel/software/enhancements/plumed-2.8.1/installed-files/bin:$PATH"
export LD_LIBRARY_PATH="/project2/andrewferguson/maxtopel/software/enhancements/plumed-2.8.1/installed-files/lib:$LD_LIBRARY_PATH"

#gmx convert-tpr -s sys-prod.tpr -o sys-prod-ext.tpr -until 1000000
#NTASKS=$(($SLURM_NTASKS_PER_NODE * $SLURM_JOB_NUM_NODES))
OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
export PLUMED_NUM_THREADS=$OMP_NUM_THREADS
#mpirun -np $NTASKS --oversubscribe 

#export OMP_NUM_THREADS=16
gmx mdrun -ntomp $OMP_NUM_THREADS -pin on -s sys-prod-ext.tpr -deffnm sys-prod -nice 1 -plumed plumed.dat -cpi sys-prod.cpt

#mpirun -np $NTASKS --oversubscribe gmx mdrun -ntomp $OMP_NUM_THREADS -pin on -plumed plumed.dat -s sys-prod.tpr -deffnm sys-prod -nice 1 -cpi sys-prod.cpt

