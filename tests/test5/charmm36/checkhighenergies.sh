#!/bin/bash
# Script to parse out high energies from generation of Q topology files
# and plot them in pymol.
# Author: Mauricio Esguerra
# Date: May 9, 2016
#
#set -x
#trap read debug

sed -n '/bond atoms/,/No. above Emax/p' generate.log > b1
sed -n '/angle  atoms/,/No. above Emax/p' generate.log > a1
sed -n '/tors    atoms/,/No. above Emax/p' generate.log > t1
sed -n '/impr atoms/,/No. above Emax/p' generate.log > i1
echo "#!/usr/bin/env python
load init.pdb" > getoffenders.pml
sed -e '$ d' b1 | sed '1d' | awk '{print "select bond"$1", ""ID "$2"+"$3}' >> getoffenders.pml
sed -e '$ d' a1 | sed '1d' | awk '{print "select angle"$1", ""ID "$2"+"$3"+"$4}' >> getoffenders.pml
sed -e '$ d' t1 | sed '1d' | awk '{print "select torsion"$1", ""ID "$2"+"$3"+"$4"+"$5}' >> getoffenders.pml
sed -e '$ d' i1 | sed '1d' | awk '{print "select improper"$1", ""ID "$2"+"$3"+"$4"+"$5}' >> getoffenders.pml
echo "select waters, resn HOH
hide lines, waters
select sodiums, resn SOD
hide everything, sodiums
hide everything
set stick_radius, 0.1
show sticks, bond*
show sticks, angle*
show sticks, torsion*
show sticks, improper*
pseudoatom comsphere, pos=[-6.54,200.95,15.49]
show sphere, comsphere
set sphere_scale, 30, comsphere
set sphere_transparency, 0.75, comsphere
deselect" >> getoffenders.pml


rm b1 a1 t1 i1


