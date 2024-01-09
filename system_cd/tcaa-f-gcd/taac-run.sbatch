#!/bin/sh
# email on start, end, and abortion
#SBATCH --job-name=TCAA-gcd-i
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

shopt -s expand_aliases
source ~/.bashrc

#Set runtime path of "/home1/03273/tg825722/software/gromacs/gromacs-2021.6/installed-files/bin/gmx" to "$ORIGIN/../lib64:/opt/apps/cuda/11.3/lib64:/opt/apps/hwloc/1.11.13/lib"

#rm -f *# sys-prod-out.mdp COLVAR HILLS BIAS logfile step* bck* bcd-sds.* hills* *.cpt *.edr *.xtc *.log *.gro

# energy minimization
#gmx grompp -f emin.mdp -c sys-neutral.gro -p sys.top -po sys-out.mdp -o sys.tpr -maxwarn 2 -r sys-neutral.gro
#gmx mdrun -s sys.tpr -deffnm sys-emin

# equilibration
#gmx grompp -f equil.mdp -c sys-emin.gro -p sys.top -po sys-equil-out.mdp -o sys-equil.tpr -maxwarn 2 -r sys-neutral.gro
#gmx mdrun -s sys-equil.tpr -deffnm sys-equil

# NPT equilibration
#gmx grompp -f equil-npt.mdp -c sys-equil.gro -p sys.top -po sys-equil-npt-out.mdp -o sys-equil-npt.tpr -maxwarn 2 -r sys-neutral.gro
#gmx mdrun -s sys-equil-npt.tpr -deffnm sys-equil-npt

## Production run

#gmx grompp -f prod.mdp -c  sys-equil-npt.gro -p sys.top -po sys-prod-out.mdp -o sys-prod.tpr -maxwarn 2 -r sys-emin.gro
#gmx mdrun -s sys-prod.tpr -deffnm sys-prod
#NTASKS=$(($SLURM_NTASKS_PER_NODE * $SLURM_JOB_NUM_NODES))
#OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
#export PLUMED_NUM_THREADS=$OMP_NUM_THREADS
#mpirun -np $NTASKS --oversubscribe 
#export OMP_NUM_THREADS=16
#gmx mdrun -ntomp $OMP_NUM_THREADS -pin on -s sys-prod.tpr -deffnm sys-prod -nice 1 -plumed plumed.dat
#mpirun -np $NTASKS --oversubscribe gmx mdrun -ntomp $OMP_NUM_THREADS -pin on -plumed plumed.dat -s sys-prod.tpr -deffnm sys-prod -nice 1 -cpi sys-prod.cpt

# NPT equilibration
#gmx grompp -f equil-npt.mdp -c sys-equil.gro -p sys.top -po sys-equil-npt-out.mdp -o sys-equil-npt.tpr -maxwarn 2 -r sys-emin.gro
#gmx mdrun -s sys-equil-npt.tpr -deffnm sys-equil-npt

## Production run
gmx grompp -f prod.mdp -c  sys-equil.gro -p sys.top -po sys-prod-out.mdp -o sys-prod.tpr -maxwarn 2
export OMP_NUM_THREADS=16
gmx mdrun -ntomp $OMP_NUM_THREADS -pin on -s sys-prod.tpr -deffnm sys-prod -nice 1 -plumed plumed.dat


