load ../frame99.pdb, spherical
load_traj ../equi.dcd, spherical
pseudoatom spherecenter, pos=[-1.386, 2.119, -1.219]
set sphere_scale, 0.1, spherecenter
show spheres, spherecenter
select sphere5,  spherecenter around 5
select sphere10, spherecenter around 10
select sphere15, spherecenter around 15
select sphere17, spherecenter around 17

pseudoatom spherical5, pos=[-1.386, 2.119, -1.219]
set sphere_scale, 5, spherical5
show spheres, spherical5
color red, spherical5
set sphere_transparency, 0.6, spherical5

pseudoatom spherical10, pos=[-1.386, 2.119, -1.219]
set sphere_scale, 10, spherical10
show spheres, spherical10
color green, spherical10
set sphere_transparency, 0.7, spherical10

pseudoatom spherical15, pos=[-1.386, 2.119, -1.219]
set sphere_scale, 15, spherical15
show spheres, spherical15
color cyan, spherical15
set sphere_transparency, 0.8, spherical15

pseudoatom spherical17, pos=[-1.386, 2.119, -1.219]
set sphere_scale, 17, spherical17
show spheres, spherical17
color orange, spherical17
set sphere_transparency, 0.9, spherical17

set sphere_quality, 6
set transparency_mode, 1

select ligand, resn LIG
show sticks, ligand
select waters, solvent

zoom waters, 3.0

deselect

set movie_panel=1
#movie.add_state_sweep(1,0,start=1)
movie.add_state_loop(1,0,start=1)
set movie_panel_row_height, 20

##Make images for movie
viewport 1200,1200
set ray_trace_frames=1
set cache_frame=0
mpng frame_
