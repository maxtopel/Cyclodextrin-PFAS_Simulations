shopt -s expand_aliases
source ~/.bashrc
prepgmx
analyte=TCAA #/home/sivadasetty/scratch-midway2/pfas/pfos-gaff/pfos-anion
probe=gcd #/home/sivadasetty/scratch-midway2/pfas/probes/beta-cd/bcd

n_analyte=$(awk '{if(NR==2){print}}' $analyte-box.gro)
n_probe=$(awk '{if(NR==2){print}}' $probe-box.gro)

natoms=$(expr $n_analyte + $n_probe)

start=$(expr $n_analyte + 3)
end=$(expr $start + 2)

gmx editconf -f $probe-box.gro -o $probe-rotate.gro -princ -center 2.5 2.5 2.5
gmx editconf -f $analyte-box.gro -o $analyte-rotate.gro -rotate 0 90 0 -center 2.5 2.5 2.5
gmx editconf -f $analyte-box.gro -o $analyte-rotate-270.gro -rotate 0 270 0 -center 2.5 2.5 2.5
cat $analyte-rotate.gro $probe-rotate.gro > temp.gro
cat $analyte-rotate-270.gro $probe-rotate.gro > temp_1.gro
cat $analyte-box.gro $probe-rotate.gro > temp_2.gro
sed "${start},${end}d" temp.gro > temp2.gro
sed "${start},${end}d" temp_1.gro > temp3.gro
sed "${start},${end}d" temp_2.gro > temp4.gro
#sed s/1PLI/2PLI/g temp2.gro > temp3.gro

# Change the number of atoms to the total number of atoms on the analyte.
# 29 should be replaced by number of SDS atoms
sed "2s/8/${natoms}/g" temp2.gro > catFile.gro
sed "2s/8/${natoms}/g" temp3.gro > catFile_1.gro
sed "2s/8/${natoms}/g" temp4.gro > catFile_2.gro
rm -f temp.gro temp2.gro temp3.gro temp4.gro

gmx editconf -f catFile.gro -o sys.gro -resnr 1
gmx editconf -f catFile_1.gro -o sys-anti.gro -resnr 1
gmx editconf -f catFile_2.gro -o sys-free.gro -resnr 1
