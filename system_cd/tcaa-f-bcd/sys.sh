shopt -s expand_aliases
source ~/.bashrc
prepgmx

analyte=TCAA 
probe=bcd

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

gmx solvate -cp sys.gro -cs spc216.gro -o sys-neutral.gro -p sys.top
gmx grompp -f emin.mdp -c sys-neutral.gro -r sys-neutral.gro -p sys.top -po sys-neutral.mdp -o sys-neutral.tpr -maxwarn 3

#gmx genion -s sys-neutral.tpr -p sys.top -o sys-neutral.gro -pname NA -pq 1 -np 1 <<EOF
#5
#EOF


