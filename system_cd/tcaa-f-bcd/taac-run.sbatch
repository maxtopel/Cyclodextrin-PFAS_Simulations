#!/bin/sh
# email on start, end, and abortion
#SBATCH --job-name=TCAA-acd-i
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

source /project/andrewferguson/Nick/gromacs-2021.1/installed-files/bin/GMXRC
export OMP_NUM_THREADS=5
plumedFile=plumed_parameterized.dat

export PATH="/project/andrewferguson/Nick/plumed2/installed-files/bin:$PATH"
export LD_LIBRARY_PATH="/project/andrewferguson/Nick/plumed2/installed-files/lib:$LD_LIBRARY_PATH"
module load openmpi/2.0.2 #4.1.2+gcc-7.4.0
module load gsl   
module load cuda/11.2
module load python

#./load_gromacs_mdw.sh 
#module unload openmpi
#module load cuda/11.5 #should be 11.3 but not avail may download
#module load gcc/9.1.0
#module load openmpi/2.0.2
#source /software/oneapi-2021.beta7-el7-x86_64/inteloneapi/setvars.sh 
#module load gromacs/2021.1+intelmpi-2019.up7+intel-19.1.1 
#module load plumed/2.8.1+oneapi-2021


## Production run
#gmx grompp -f prod.mdp -c  sys-equil.gro -p sys.top -po sys-prod-out.mdp -o sys-prod.tpr -maxwarn 2
#export OMP_NUM_THREADS=16
#gmx mdrun -ntomp $OMP_NUM_THREADS -pin on -s sys-prod.tpr -deffnm sys-prod -nice 1 -plumed plumed.dat

GMXRC grompp -f prod.mdp -c  sys-equil.gro -p sys.top -po sys-prod-out.mdp -o sys-prod.tpr -maxwarn 2
export OMP_NUM_THREADS=16
GMXRC mdrun -ntomp $OMP_NUM_THREADS -pin on -s sys-prod.tpr -deffnm sys-prod -nice 1 -plumed plumed.dat

