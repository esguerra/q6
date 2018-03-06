#!/bin/python
load ../init.pdb, equi
load_traj ../start.dcd, equi
for i in range(1,6): cmd.load_traj("../heat%1d.dcd"%i,"equi")
for i in range(1,7): cmd.load_traj("../relax%1d.dcd"%i,"equi")
load_traj equi.dcd, equi

hide everything, all
select waters, resn HOH
select ligand, resn LIG
select dhfr, not waters or ligand
deselect

show spheres, ligand
show lines, waters
show cartoon, dhfr

spectrum count, rainbow, dhfr

#set_color oxygen, [1.0,0.4,0.4]
#set_color nitrogen, [0.5,0.5,1.0]
#as spheres, resn LIG
#as sticks,  resn HOH

#util.cbaw
#set light_count,8
#set spec_count,1
#set shininess, 10
#set specular, 0.25
#set ambient,0
#set direct,0
#set reflect,1.5
#set ray_shadow_decay_factor, 0.1
#set ray_shadow_decay_range, 2
#unset depth_cue
# for added coolness
#set field_of_view, 60
#set sphere_scale, 1
#set sphere_quality, 3
#set antialias, 10
#color grey50, elem c

#set ray_shadow_decay_range, -5
#color grey10, elem c
#color blue,   elem n

# set the view
#orient all within 8 of lig


#zoom ligand
cmd.hide("(lig and hydro and (elem c extend 1))")

#set ray_trace_mode, 1
#intra_fit ligand and heat
#zoom ligand

set movie_panel=1
movie.add_state_loop(1,0,start=1)
#movie.add_state_sweep(1,0,start=1)
set movie_panel_row_height, 20
