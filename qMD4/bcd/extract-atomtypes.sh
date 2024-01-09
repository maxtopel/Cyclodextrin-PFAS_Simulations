fileName="bcd"

molLine=$(awk '/moleculetype/{print NR}' q4MD-CycloDextrin/$fileName".top")
echo $molLine
echo "d"
nline=$(expr $molLine - 1 )

start=1
end=$nline

awk -v l=$end 'NR<=l{print}' q4MD-CycloDextrin/$fileName".top" > $fileName-ffatoms.itp
sed "${start},${end}d" q4MD-CycloDextrin/$fileName".top" > temp.itp


sed "${start},${end}d" q4MD-CycloDextrin/$fileName".top" > $fileName-ff.itp


rm -f temp.itp


