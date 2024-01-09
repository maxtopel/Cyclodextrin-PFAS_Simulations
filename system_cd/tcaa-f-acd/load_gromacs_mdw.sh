source /project/andrewferguson/Nick/gromacs-2021.1/installed-files/bin/GMXRC
export OMP_NUM_THREADS=5
plumedFile=plumed_parameterized.dat

export PATH="/project/andrewferguson/Nick/plumed2/installed-files/bin:$PATH"
export LD_LIBRARY_PATH="/project/andrewferguson/Nick/plumed2/installed-files/lib:$LD_LIBRARY_PATH"
module load openmpi/4.1.2+gcc-7.4.0
module load gsl
module load cuda/11.2
module load python



#module load cuda/11.5 #should be 11.3 but not avail may download
#module load gcc/9.1.0
#export PATH=/project2/andrewferguson/maxtopel/software/enhancements/plumed-2.8.1/installed-files/bin:$PATH
#export LIBRARY_PATH=/project2/andrewferguson/maxtopel/software/enhancements/plumed-2.8.1/installed-files/lib:$LIBRARY_PATH
#export LD_LIBRARY_PATH=/project2/andrewferguson/maxtopel/software/enhancements/plumed-2.8.1/installed-files/lib:$LD_LIBRARY_PATH
#export PLUMED_KERNEL=/project2/andrewferguson/maxtopel/software/enhancements/plumed-2.8.1/installed-files/lib/libplumedKernel.so
#echo PATH=/project2/andrewferguson/maxtopel/software/enhancements/openmpi/openmpi-2.0.2/installed-files/bin:$PATH
#echo LIBRARY_PATH=/project2/andrewferguson/maxtopel/software/enhancements/openmpi/openmpi-2.0.2/installed-files/lib:$PATH
#export LD_LIBRARY_PATH=/project2/andrewferguson/maxtopel/software/enhancements/openmpi/openmpi-2.0.2/installed-files/lib:$LD_LIBRARY_PATH
#source /project2/andrewferguson/maxtopel/software/gromacs/gromacs-2021.6/installed-files/bin/GMXRC


