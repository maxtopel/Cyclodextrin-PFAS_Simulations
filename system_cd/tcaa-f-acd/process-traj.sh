#module load cuda/11.3
#module load gcc/9.1.0
module unload gcc
module load gcc/9.1.0 
module load openmpi/2.0.2
module unload gromacs
module load cuda/9.2
module load gromacs

# Post-processing of trajectory to remove water and to center analyte for easy visual analysis

#for file in pfosd-beta-cd/orient-1 pfosd-beta-cd/orient-1-unrestrained sds-beta-cd/orient-1 sds-beta-cd/orient-1-unrestrained
for file in ../sds-f-acd/sphere_2nm #../sds-f-acd/sphere_2nm
do
 
fileName=sys-prod
gmx_mpi convert-tpr -s $file/$fileName.tpr -o $file/$fileName-nonwater.tpr <<EOF
non-Water
EOF

cp  $file/sys-equil-npt.gro  $file/sys-prod.gro
# Enable this if simulation is complete
gmx_mpi trjconv -f $file/$fileName.gro -s $file/$fileName.tpr -o $file/$fileName-nonwater.gro <<EOF                      
non-Water                                                                                                               
EOF

# Create index file
#rm -f $file/index-in.ndx
gmx_mpi make_ndx -f $file/$fileName.gro -o $file/index.ndx <<EOF
name 2 ANA
name 3 PRO
2 | 3
q
EOF

trajName=$fileName
# Translation fit to keep the focus on probe and analyte during visual analysis
gmx_mpi trjconv -f $file/$trajName.xtc -s $file/$fileName.tpr -o $file/$trajName-nonwater-fit.xtc -fit trans -n $file/index.ndx <<EOF
ANA_PRO
non-Water
EOF

# Enable this if simulation is complete
gmx_mpi make_ndx -f $file/$fileName-nonwater.gro -o $file/index-nonwater.ndx <<EOF
2
3
name 2 ANA
name 3 PRO
2 | 3
q
EOF

# PBC correction to keep both residues in the box
gmx_mpi trjconv -f $file/$trajName-nonwater-fit.xtc -s $file/$fileName-nonwater.tpr -o $file/$trajName-nonwater-fit-res.xtc -pbc res <<EOF
0
EOF

# Center for keeping the probe in the center of the box
# Download this trajectory for visual analysis
gmx_mpi trjconv -f $file/$trajName-nonwater-fit-res.xtc -s $file/$fileName-nonwater.tpr -o $file/$trajName-nonwater-fit-res-center.xtc -center -pbc nojump -n $file/index-nonwater.ndx <<EOF
ANA_PRO
0
EOF

gmx_mpi trjconv -f $file/$fileName-nonwater.gro -n $file/index-nonwater.ndx -o $file/$fileName-solutes.gro -s $file/$fileName-nonwater.gro <<EOF
ANA_PRO
EOF

gmx_mpi trjconv -f $file/$trajName-nonwater-fit-res-center.xtc -s $file/$fileName-nonwater.tpr -o $file/$trajName-nonwater-fit-res-center-fit.xtc -fit rot+trans -n $file/index-nonwater.ndx -dt 40 <<EOF
ANA_PRO
ANA_PRO
EOF



# Remove intermediate files
#rm -f $file/$trajName-nonwater-fit-res.xtc $file/$trajNam-nonwater-fit.xtc 
rm -f $file/*#

done
