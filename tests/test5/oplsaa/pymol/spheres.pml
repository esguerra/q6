load ../init.pdb, spherical
load_traj ../equi.dcd, spherical
pseudoatom spherecenter, pos=[-1.386, 2.119, -1.219]
set sphere_scale, 0.1, spherecenter
show spheres, spherecenter
hide everything, all
select ligand, resn LIG
select waters, resn HOH
select sphere5,  spherecenter around 5
select sphere10, spherecenter around 10
select sphere15, spherecenter around 15
select sphere17, spherecenter around 17

turn y, 30

#util.cbaw
set light_count,8
set spec_count,1
set shininess, 10
set specular, 0.25
set ambient,0
set direct,0
set reflect,1.5
set ray_shadow_decay_factor, 0.1
set ray_shadow_decay_range, 2
unset depth_cue
set sphere_scale, 1
set sphere_quality, 3

fraction=0.44
view=cmd.get_view()
near_dist=fraction*(view[16]-view[15])
far_dist=(view[16]-view[15])-near_dist
cmd.clip("near",-near_dist)


pseudoatom spherical5, pos=[-1.386, 2.119, -1.219]
set sphere_scale, 5, spherical5
color red, spherical5
show spheres, spherical5
#set sphere_transparency, 0.5, spherical5

pseudoatom spherical10, pos=[-1.386, 2.119, -1.219]
set sphere_scale, 10, spherical10
color green, spherical10
show spheres, spherical10
#set sphere_transparency, 0.0, spherical10

pseudoatom spherical15, pos=[-1.386, 2.119, -1.219]
set sphere_scale, 15, spherical15
color cyan, spherical15
show spheres, spherical15
#set transparency, 0.1, spherical15

pseudoatom spherical17, pos=[-1.386, 2.119, -1.219]
set sphere_scale, 17, spherical17
color orange, spherical17
show spheres, spherical17
#set sphere_transparency, 0.5, spherical17

show sticks, waters
show sticks, ligand
set sphere_transparency, 0.2, spherical5 or spherical10 or spherical15 or spherical17
set transparency_mode, 3
set ray_interior_reflect, 0.6
#set ray_interior_color, gray30
set opaque_background



#show spheres, ligand

png part1.png, width=1200, height=1200, dpi=600, ray=1


cmd.clip("near", near_dist)
cmd.clip("far", far_dist)

hide everything
show sticks, ligand
unset opaque_background
png part2.png, width=1200, height=1200, dpi=600, ray=1


system composite part2.png part1.png image_merged.png

