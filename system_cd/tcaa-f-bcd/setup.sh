shopt -s expand_aliases
source ~/.bashrc
prepgmx
# energy minimization
gmx grompp -f emin.mdp -c sys-neutral.gro -p sys.top -po sys-out.mdp -o sys.tpr -maxwarn 2 -r sys-neutral.gro
gmx mdrun -s sys.tpr -deffnm sys-emin

# equilibration
gmx grompp -f equil.mdp -c sys-emin.gro -p sys.top -po sys-equil-out.mdp -o sys-equil.tpr -maxwarn 2 -r sys-neutral.gro
gmx mdrun -s sys-equil.tpr -deffnm sys-equil

# NPT equilibration
gmx grompp -f equil-npt.mdp -c sys-equil.gro -p sys.top -po sys-equil-npt-out.mdp -o sys-equil-npt.tpr -maxwarn 2 -r sys-neutral.gro
gmx mdrun -s sys-equil-npt.tpr -deffnm sys-equil-npt

