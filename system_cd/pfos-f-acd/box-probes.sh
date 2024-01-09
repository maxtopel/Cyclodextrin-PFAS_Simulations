module load cuda/11.3
module load gcc/9.1.0

export PATH=/work2/03273/tg825722/shared-folder-siva/software/enhancements/plumed-2.8.1/installed-files/bin:$PATH
export LIBRARY_PATH=/work2/03273/tg825722/shared-folder-siva/software/enhancements/plumed-2.8.1/installed-files/lib:$LIBRARY_PATH
export LD_LIBRARY_PATH=/work2/03273/tg825722/shared-folder-siva/software/enhancements/plumed-2.8.1/installed-files/lib:$LD_LIBRARY_PATH
export PLUMED_KERNEL=/work2/03273/tg825722/shared-folder-siva/software/enhancements/plumed-2.8.1/installed-files/lib/libplumedKernel.so

echo PATH=/work2/03273/tg825722/shared-folder-siva/software/enhancements/openmpi/openmpi-2.0.2/installed-files/bin:$PATH
echo LIBRARY_PATH=/work2/03273/tg825722/shared-folder-siva/software/enhancements/openmpi/openmpi-2.0.2/installed-files/lib:$PATH
export LD_LIBRARY_PATH=/work2/03273/tg825722/shared-folder-siva/software/enhancements/openmpi/openmpi-2.0.2/installed-files/lib:$LD_LIBRARY_PATH

source /work2/03273/tg825722/shared-folder-siva/software/gromacs/gromacs-2021.6/installed-files/bin/GMXRC




for fileName in acd

do
#9
$fileName.gro
gmx editconf -princ -f $fileName.gro -o $fileName-box.gro -box 7 7 7 -center 3.5 3.5 3.5 <<EOF
0
EOF

done


for fileName in pfos-anion

do
#SDS
#9
gmx editconf -f $fileName.gro -o $fileName-box.gro -box 7 7 7 -center 3.5 3.5 4.5 <<EOF
0
EOF



done
