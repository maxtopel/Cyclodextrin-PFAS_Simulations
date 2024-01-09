# Change the following two lines for setting up different analytes and probes

analyte=sds #pfos-anion
probe=acd


gmx genrestr -f $probe-box.gro -o probe-posres.itp -fc 500 500 500 <<EOF 
2
EOF

gmx genrestr -f $analyte-box.gro -o analyte-posres.itp -fc 500 500 500 <<EOF
2
EOF



