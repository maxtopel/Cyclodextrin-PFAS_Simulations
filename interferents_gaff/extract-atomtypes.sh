fileName=MOL
reName=TCAA
resname=TCAA

molLine=$(awk '/molecule/{print NR}' $reName"-resp"/2_top/MOL.acpype/$fileName"_GMX.itp")
echo $molLine
nline=$(expr $molLine - 1 )

start=1
end=$nline

awk -v l=$end 'NR<=l{print}' $reName"-resp"/2_top/MOL.acpype/$fileName"_GMX.itp" > $reName-ffatoms.itp
sed "${start},${end}d" $reName"-resp"/2_top/MOL.acpype/$fileName"_GMX.itp" > temp.itp

sed s/MOL/${reName^^}/g $reName"-resp"/2_top/MOL.acpype/$fileName"_GMX.gro" > $reName.gro

sed s/MOL/${resname^^}/g temp.itp > $reName-ff.itp

rm -f temp.itp



