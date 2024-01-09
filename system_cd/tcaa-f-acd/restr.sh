# Change the following two lines for setting up different analytes and probes
alias gmx='/project2/andrewferguson/maxtopel/software/gromacs/gromacs-2021.6/installed-files/bin/gmx'
module load openmpi/4.1.2+gcc-10.2.0 gsl cuda/11.2 python
export PATH="/project2/andrewferguson/maxtopel/software/enhancements/plumed-2.8.1/installed-files/bin:$PATH"
export LD_LIBRARY_PATH="/project2/andrewferguson/maxtopel/software/enhancements/plumed-2.8.1/installed-files/lib:$LD_LIBRARY_PATH"


analyte=TCAA
probe=acd


gmx genrestr -f $probe-box.gro -o probe-posres.itp -fc 500 500 500 <<EOF 
2
EOF

gmx genrestr -f $analyte-box.gro -o analyte-posres.itp -fc 500 500 500 <<EOF
2
EOF



