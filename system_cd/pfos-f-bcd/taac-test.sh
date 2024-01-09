module load cuda/11.3
#module load cuda/11.0
#module load gcc/6.3.0
module load gcc/9.1.0

export PATH=/home1/03273/tg825722/software/enhancements/plumed-2.8.1/installed-files/bin:$PATH
export LIBRARY_PATH=/home1/03273/tg825722/software/enhancements/plumed-2.8.1/installed-files/lib:$LIBRARY_PATH 
export LD_LIBRARY_PATH=/home1/03273/tg825722/software/enhancements/plumed-2.8.1/installed-files/lib:$LD_LIBRARY_PATH                
export PLUMED_KERNEL=/home1/03273/tg825722/software/enhancements/plumed-2.8.1/installed-files/lib/libplumedKernel.so

source /home1/03273/tg825722/software/gromacs/gromacs-2021.6/installed-files/bin/GMXRC

#Set runtime path of "/home1/03273/tg825722/software/gromacs/gromacs-2021.6/installed-files/bin/gmx" to "$ORIGIN/../lib64:/opt/apps/cuda/11.3/lib64:/opt/apps/hwloc/1.11.13/lib"

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

rm -f *# sys-prod.xtc sys-prod-out.mdp sys-prod.log sys-prod.edr COLVAR HILLS BIAS logfile step*
gmx grompp -f prod.mdp -c  sys-equil.gro -p sys.top -po sys-prod-out.mdp -o sys-prod.tpr -maxwarn 2 -r sys-neutral.gro

#gmx mdrun -s sys-prod.tpr -deffnm sys-prod

#NTASKS=$(($SLURM_NTASKS_PER_NODE * $SLURM_JOB_NUM_NODES))
#OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
#export PLUMED_NUM_THREADS=$OMP_NUM_THREADS
#mpirun -np $NTASKS --oversubscribe 

export OMP_NUM_THREADS=20
gmx mdrun -ntomp 20 -pin on -s sys-prod.tpr -deffnm sys-prod -nice 1 -plumed plumed.dat

#mpirun -np $NTASKS --oversubscribe gmx mdrun -ntomp $OMP_NUM_THREADS -pin on -plumed plumed.dat -s sys-prod.tpr -deffnm sys-prod -nice 1 -cpi sys-prod.cpt

