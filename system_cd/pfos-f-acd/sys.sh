# Change the following two lines for setting up different analytes and probes

analyte=pfos-anion 
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

cat $analyte-box.gro $probe-box.gro > temp.gro

sed "${start},${end}d" temp.gro > temp2.gro

# Change the number of atoms to the total number of atoms on the analyte.
# 29 should be replaced by number of SDS atoms
sed "2s/29/${natoms}/g" temp2.gro > catFile.gro

rm -f temp.gro temp2.gro 
gmx editconf -f catFile.gro -o sys.gro -resnr 1
rm -f catFile* temp*

gmx solvate -cp sys.gro -cs spc216.gro -o sys-solvated.gro -p sys.top
gmx grompp -f emin.mdp -c sys-solvated.gro -r sys-solvated.gro -p sys.top -po sys-neutral.mdp -o sys-neutral.tpr -maxwarn 3
gmx genion -s sys-neutral.tpr -p sys.top -o sys-neutral.gro -pname NA -pq 1 -np 1 <<EOF
5
EOF


