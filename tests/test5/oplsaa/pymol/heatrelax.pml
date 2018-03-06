#!/bin/python
load ../init.pdb, full
#load ../init.pdb, heat
#load ../init.pdb, relax
#load ../init.pdb, equi
load_traj ../start.dcd, full
for i in range(1,6): cmd.load_traj("../heat%1d.dcd"%i,"full")
for i in range(1,7): cmd.load_traj("../relax%1d.dcd"%i,"full")
load_traj ../equi.dcd, equi

hide everything, all
select waters, resn HOH
select ligand, resn LIG
select protein, not (resn HOH  or resn LIG)
deselect

#set_color oxygen, [1.0,0.4,0.4]
#set_color nitrogen, [0.5,0.5,1.0]
#as spheres, resn LIG
#as sticks,  resn HOH
util.cbaw
set light_count,8
set spec_count,1
set shininess, 10
set specular, 0.25
set ambient,0
set direct,0
set reflect,1.5
set ray_shadow_decay_factor, 0.1
set ray_shadow_decay_range, 2
#unset depth_cue
# for added coolness
#set field_of_view, 60
set sphere_scale, 1
set sphere_quality, 3
#set antialias, 10
#color grey50, elem c

set ray_shadow_decay_range, -5
color grey10, elem c
color blue,   elem n

# set the view
#orient all within 8 of lig

### cut below here and paste into script ###
#set_view (\
#     0.094790287,    0.861110687,   -0.499495089,\
#     0.040653467,    0.497986287,    0.866229594,\
#     0.994662583,   -0.102417387,    0.012199387,\
#     0.000000000,    0.000000000, -175.014495850,\
#    -0.257192612,    0.564195633,   -1.739809990,\
#   137.982757568,  173.533233643,   20.000000000 )
### cut above here and paste into script ###
show spheres, ligand
show stick, waters
show cartoon, protein
spectrum count, rainbow, protein

#zoom ligand
cmd.hide("(lig and hydro and (elem c extend 1))")

set ray_trace_mode, 1
#intra_fit ligand and heat
#intra_fit ligand and full
#zoom ligand
intra_fit protein and full
zoom protein

#set movie_panel=1
#movie.add_state_loop(1,0,start=1)
#movie.add_state_sweep(1,0,start=1)
#set movie_panel_row_height, 20
