#source /project/andrewferguson/Nick/gromacs-2021.1/installed-files/bin/GMXRC
#export PATH="/project/andrewferguson/Nick/plumed2/installed-files/bin:$PATH"
#export LD_LIBRARY_PATH="/project/andrewferguson/Nick/plumed2/installed-files/lib:$LD_LIBRARY_PATH"
source /project2/andrewferguson/maxtopel/software/gromacs/gromacs-2021.6/installed-files/bin/gmx
#source /project2/andrewferguson/maxtopel/software/gromacs/gromacs-2021.6/installed-files/bin/gmx
module load openmpi/4.1.2+gcc-10.2.0 gsl cuda/11.2 python
export PATH="/project2/andrewferguson/maxtopel/software/enhancements/plumed-2.8.1/installed-files/bin:$PATH"
export LD_LIBRARY_PATH="/project2/andrewferguson/maxtopel/software/enhancements/plumed-2.8.1/installed-files/lib:$LD_LIBRARY_PATH"

# energy minimization
gmx grompp -f emin.mdp -c sys-neutral.gro -p sys.top -po sys-out.mdp -o sys.tpr -maxwarn 2 -r sys-neutral.gro
gmx mdrun -s sys.tpr -deffnm sys-emin

# equilibration
gmx grompp -f equil.mdp -c sys-emin.gro -p sys.top -po sys-equil-out.mdp -o sys-equil.tpr -maxwarn 2 -r sys-neutral.gro
gmx mdrun -s sys-equil.tpr -deffnm sys-equil

# NPT equilibration
gmx grompp -f equil-npt.mdp -c sys-equil.gro -p sys.top -po sys-equil-npt-out.mdp -o sys-equil-npt.tpr -maxwarn 2 -r sys-neutral.gro
gmx mdrun -s sys-equil-npt.tpr -deffnm sys-equil-npt

