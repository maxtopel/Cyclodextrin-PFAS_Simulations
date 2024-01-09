shopt -s expand_aliases
source ~/.bashrc
prepgmx
export PATH="/project2/andrewferguson/maxtopel/software/enhancements/plumed-2.8.1/installed-files/bin:$PATH"
export LD_LIBRARY_PATH="/project2/andrewferguson/maxtopel/software/enhancements/plumed-2.8.1/installed-files/lib:$LD_LIBRARY_PATH"

# Post-processing of trajectory to remove water and to center analyte for easy $

for probe in 'acd' 'bcd' 'gcd'
do
#filepath='/project2/andrewferguson/maxtopel/PFAS_TACC/system-cd/TCAA-f-'$probe'/sphere_2nm-weak'
filepath='/project2/andrewferguson/maxtopel/PFAS_TACC/system-cd/pfos-f-'$probe'/sphere_2nm_cp'

for file in $filepath
do

#fileName="sys-prod-plumed2"
fileName="sys-prod"

#orient
#gmx convert-tpr -s pfosd-beta-cd-unbiased/orient-1-unrestrained-2/sys-prod.tpr -o $file/$fileName-nonwater-orient1.tpr <<EOF
#non-Water
#EOF

gmx convert-tpr -s $file/$fileName.tpr -o $probe/$fileName-nonwater.tpr <<EOF
non-Water
EOF

# Enable this if simulation is complete
gmx trjconv -f $file/$fileName.gro -s $file/$fileName.tpr -o $probe/$fileName-nonwater.gro <<EOF                      
non-Water                                                                                                               
EOF

# Create index file
#rm -f $file/index-in.ndx
gmx make_ndx -f $file/$fileName.gro -o $probe/index.ndx <<EOF
name 2 ANA
name 3 PRO
q
EOF

trajName=$fileName
# Translation fit to keep the focus on probe during visual analysis
gmx trjconv -f $file/$trajName.xtc -s $probe/$fileName-nonwater.tpr -o $probe/$trajName-nonwater-fit.xtc -fit trans -n $probe/index.ndx <<EOF
PRO
non-Water
EOF

# Enable this if simulation is complete
gmx make_ndx -f $probe/$fileName-nonwater.gro -o $probe/index-nonwater.ndx <<EOF
2
3
q
EOF

# PBC correction to keep both residues in the box
gmx trjconv -f $probe/$trajName-nonwater-fit.xtc -s $probe/$fileName-nonwater.tpr -o $probe/$trajName-nonwater-fit-res.xtc -pbc res <<EOF
0
EOF

# Center for keeping the probe in the center of the box
# Download this trajectory for visual analysis
gmx trjconv -f $probe/$trajName-nonwater-fit-res.xtc -s $probe/$fileName-nonwater.tpr -o $probe/$trajName-nonwater-fit-res-center.xtc -center -n $probe/index-nonwater.ndx <<EOF
3
0
EOF

gmx trjconv -f $probe/$trajName-nonwater-fit-res-center.xtc -s $probe/$fileName-nonwater.tpr -o $probe/$trajName-nonwater-fit-res-center-nojump.xtc -pbc whole -n $probe/index-nonwater.ndx -center <<EOF
3
0
EOF

rm -f $probe/*#

# Remove intermediate files
rm -f $probe/$trajName-nonwater-fit-res.xtc $probe/$trajNam-nonwater-fit.xtc 

done
done
