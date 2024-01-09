#!/bin/sh
#SBATCH -J acd-sds        # Job name
#SBATCH -o acd-sds.o%j    # Name of stdout output file
#SBATCH -e acd-sds.e%j    # Name of stderr error file
#SBATCH -p rtx-dev              # Queue (partition) name
#SBATCH -N 1               # Total # of nodes (must be 1 for serial)
#SBATCH -n 16               # Total # of mpi tasks (should be 1 for serial)
#SBATCH -t 00:30:00        # Run time (hh:mm:ss)
#SBATCH --mail-type=all    # Send email at begin and end of job
#SBATCH -A DMS22011        # Project/Allocation name (req'd if you have more than 1)
#SBATCH --mail-user=maxtopel@uchicago.edu

module load cuda/11.3
module load gcc/9.1.0

source load-gromacs.sh

#Set runtime path of "/home1/03273/tg825722/software/gromacs/gromacs-2021.6/installed-files/bin/gmx" to "$ORIGIN/../lib64:/opt/apps/cuda/11.3/lib64:/opt/apps/hwloc/1.11.13/$

#rm -f *# sys-prod-out.mdp COLVAR HILLS BIAS logfile step* bck* bcd-sds.* hills* *.cpt *.edr *.xtc *.log *.gro

# energy minimization
gmx grompp -f emin.mdp -c sys-neutral.gro -p sys.top -po sys-out.mdp -o sys.tpr -maxwarn 2 -r sys-neutral.gro

gmx mdrun -s sys.tpr -deffnm sys-emin

# equilibration
gmx grompp -f equil.mdp -c sys-emin.gro -p sys.top -po sys-equil-out.mdp -o sys-equil.tpr -maxwarn 2 -r sys-neutral.gro

gmx mdrun -s sys-equil.tpr -deffnm sys-equil

# NPT equilibration
gmx grompp -f equil-npt.mdp -c sys-equil.gro -p sys.top -po sys-equil-npt-out.mdp -o sys-equil-npt.tpr -maxwarn 2 -r sys-neutral.gro

gmx mdrun -s sys-equil-npt.tpr -deffnm sys-equil-npt

