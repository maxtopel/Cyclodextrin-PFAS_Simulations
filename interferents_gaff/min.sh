mol=TCAA
#~/Software/avogadro/openbabel-3.1.1/installed-files/bin/obabel 
obabel TCAA2.pdb -O TCAA2.pdb --minimize --log --crit 1e-06 --ff UFF --steps 2500 --rvdw 10 --rele 10 --freq 10 --verbose

#-ipdb $mol.pdb -omol $mol-2.pdb --minimize --log --crit 1e-06 --ff UFF --steps 2500 --rvdw 10 --rele 10 --freq 10 --verbose
#-imol2 $mol.mol2 -omol $mol-2.mol2 --minimize --log --crit 1e-06 --ff UFF --steps 2500 --rvdw 10 --rele 10 --freq 10 --verbose

