# Change the following two lines for setting up different analytes and probes

#module load gcc/6.2
#module load openmpi/2.0.2
#module load cmake
#module load eigen/3.2
#module load gsl
#module load cuda/9.2
#module load python/anaconda-2020.02
#source activate gaussian
#module load intel
#
#source /project2/andrewferguson/sivadasetty/software/gromacs/gromacs-2018.6/installed-files/bin/GMXRC
#source /project2/andrewferguson/sivadasetty/software/scripts/plumed2.5.2-alltools.sh

module load openmpi/4.1.2+gcc-7.4.0
module load gsl   
module load cuda/11.2
module load python

source /project/andrewferguson/Nick/gromacs-2021.1/installed-files/bin/GMXRC
export PATH="/project/andrewferguson/Nick/plumed2/installed-files/bin:$PATH"
export LD_LIBRARY_PATH="/project/andrewferguson/Nick/plumed2/installed-files/lib:$LD_LIBRARY_PATH"


analyte=TCAA 
probe=acd

awk 'NR>8{print}' $probe-ffatoms.itp > temp.itp
cat $analyte-ffatoms.itp temp.itp water-ffatoms.itp ions-ffatoms.itp > sys-ffatoms.itp
rm -f temp.itp

#cat $analyte-ffatoms.itp $probe-ffatoms.itp water-ffatoms.itp ions-ffatoms.itp > sys-ffatoms.itp

n_analyte=$(awk '{if(NR==2){print}}' $analyte-box.gro)
n_probe=$(awk '{if(NR==2){print}}' $probe-box.gro)

natoms=$(expr $n_analyte + $n_probe)

start=$(expr $n_analyte + 3)
end=$(expr $start + 2)

#cat $analyte-box.gro $probe-box.gro > temp.gro
#sed "${start},${end}d" temp.gro > temp2.gro

# Change the number of atoms to the total number of atoms on the analyte.
# 29 should be replaced by number of SDS atoms
#sed "2s/8/${natoms}/g" temp2.gro > catFile.gro

#rm -f temp.gro temp2.gro 
#gmx editconf -f catFile.gro -o sys.gro -resnr 1
#rm -f catFile* temp*

gmx solvate -cp sys.gro -cs spc216.gro -o sys-neutral.gro -p sys.top
gmx grompp -f emin.mdp -c sys-neutral.gro -r sys-neutral.gro -p sys.top -po sys-neutral.mdp -o sys-neutral.tpr -maxwarn 3

#gmx genion -s sys-neutral.tpr -p sys.top -o sys-neutral.gro -pname NA -pq 1 -np 1 <<EOF
#5
#EOF


