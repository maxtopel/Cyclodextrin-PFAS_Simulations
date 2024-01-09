module unload gcc
module unload openmpi
module unload cuda
module load gcc/6.2
module load openmpi/2.0.2
module load cmake/3.15
module load eigen/3.2
module load gsl
module load cuda/9.2
module load python/anaconda-2020.02

source /project2/andrewferguson/sivadasetty/software/gromacs/gromacs-2018.6/installed-files/bin/GMXRC
source /project2/andrewferguson/sivadasetty/software/scripts/plumed2.5.2-alltools.sh

gmx gyrate -f TCAA.gro -s TCAA.gro -o TCAA.xvg <<EOF
0
EOF
