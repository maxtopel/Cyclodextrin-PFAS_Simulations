shopt -s expand_aliases
source ~/.bashrc
prepgmx
export PATH="/project2/andrewferguson/maxtopel/software/enhancements/plumed-2.8.1/installed-files/bin:$PATH"
export LD_LIBRARY_PATH="/project2/andrewferguson/maxtopel/software/enhancements/plumed-2.8.1/installed-files/lib:$LD_LIB$


# Post-processing of trajectory to remove water and to center analyte for easy $

#for file in pfosd-beta-cd/orient-1 pfosd-beta-cd/orient-1-unrestrained sds-bet$
#for file in ../sds-f-bcd/sphere_2nm #../sds-f-acd/sphere_2nm
#do

fileName=sys-free-prod

#orient
#gmx convert-tpr -s pfosd-beta-cd-unbiased/orient-1-unrestrained-2/sys-prod.tpr -o $file/$fileName-nonwater-orient1.tpr <<EOF
#non-Water
#EOF

gmx convert-tpr -s $file/$fileName.tpr -o $file/$fileName-nonwater.tpr <<EOF
non-Water
EOF

# Enable this if simulation is complete
gmx trjconv -f $file/$fileName.gro -s $file/$fileName.tpr -o $file/$fileName-nonwater.gro <<EOF                      
non-Water                                                                                                               
EOF

# Create index file
#rm -f $file/index-in.ndx
gmx make_ndx -f $file/$fileName.gro -o $file/index.ndx <<EOF
name 2 ANA
name 3 PRO
q
EOF

trajName=$fileName
# Translation fit to keep the focus on probe during visual analysis
gmx trjconv -f $file/$trajName.xtc -s $file/$fileName-nonwater.tpr -o $file/$trajName-nonwater-fit.xtc -fit trans -n $file/index.ndx <<EOF
PRO
non-Water
EOF

# Enable this if simulation is complete
gmx make_ndx -f $file/$fileName-nonwater.gro -o $file/index-nonwater.ndx <<EOF
2
3
q
EOF

# PBC correction to keep both residues in the box
gmx trjconv -f $file/$trajName-nonwater-fit.xtc -s $file/$fileName-nonwater.tpr -o $file/$trajName-nonwater-fit-res.xtc -pbc res <<EOF
0
EOF

# Center for keeping the probe in the center of the box
# Download this trajectory for visual analysis
gmx trjconv -f $file/$trajName-nonwater-fit-res.xtc -s $file/$fileName-nonwater.tpr -o $file/$trajName-nonwater-fit-res-center.xtc -center -n $file/index-nonwater.ndx <<EOF
3
0
EOF

gmx trjconv -f $file/$trajName-nonwater-fit-res-center.xtc -s $file/$fileName-nonwater.tpr -o $file/$trajName-nonwater-fit-res-center-nojump.xtc -pbc whole -n $file/index-nonwater.ndx -center <<EOF
3
0
EOF

rm -f $file/*#

# Remove intermediate files
rm -f $file/$trajName-nonwater-fit-res.xtc $file/$trajNam-nonwater-fit.xtc 

done
