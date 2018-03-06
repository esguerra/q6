#!/usr/bin/env python
load ../init.pdb
select angle1271, ID 686+689+691
select angle1274, ID 692+689+691
select waters, resn HOH
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
deselect
