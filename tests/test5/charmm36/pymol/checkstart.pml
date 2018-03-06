#!/usr/bin/env python
load ../init.pdb
load_traj ../start.dcd, init
load_traj ../heat1.dcd, init
select waters, resn HOH
select dhfr, not resn HOH
hide everything
show cartoon, dhfr
spectrum count, rainbow, dhfr
deselect
