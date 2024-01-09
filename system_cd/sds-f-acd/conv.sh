gmx trjconv -f sys-prod.xtc -s sys-prod.tpr -o acd_frame.pdb -b 500000.000000 -dump 500000.000000 <<EOF
3
EOF

gmx trjconv -f sys-prod.xtc -s sys-prod.tpr -o acd_frame.gro -b 500000.000000 -dump 500000.000000 <<EOF
3
EO
