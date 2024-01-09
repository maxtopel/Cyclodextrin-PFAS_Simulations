mol=TCAA3

rm -r $mol-resp
cp -r ../gaff-resp/template/ $mol-resp

cd $mol-resp

cp ../$mol.pdb 0_geoOpt/.

sed s/mol.pdb/$mol.pdb/g gen_top.sh > a.sh

sed s/NAME/$mol/g sbatch.sbatch > b.sh

mv a.sh gen_top.sh

mv b.sh sbatch.sbatch

