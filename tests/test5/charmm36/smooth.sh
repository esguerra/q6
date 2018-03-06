#!/bin/bash
#set -x
#trap read debug

qprep < generate.inp > generate.log
time mpirun -np 8 qdynp start.inp > start.log

################################################################################
# HEATING: This is a for loop to heat smoothly from 1 to 300 Kelvin (27 Celsius)
# which is NOT the physiological temperature.
################################################################################
time mpirun -np 8 qdynp heat1.inp > heat1.log
for i in $(seq -w 2 1 6)
do
        j=`expr $i "-" 1`
        k=`expr $i "+" 1`
        l=`expr $i "*" 50`
        m=`expr $l "-" 50`
echo "[MD]
steps                     1000
stepsize                  2
temperature               "$l"
bath_coupling             10
!random_seed               "$RANDOM"
initial_temperature       "$m"
shake_solvent             on
shake_hydrogens           on
shake_solute              off
lrf                       on

[cut_offs]
solute_solute             10.0
solute_solvent            99.0
solvent_solvent           99.0
q_atom                    99.0
lrf                       99.0

[sphere]
shell_force               10
shell_radius              0.8

[solvent]
radial_force              60.0
polarization              on
polarization_force        20.0

[intervals]
non_bond                  20
output                    10
energy                    0
trajectory                10

[files]
topology                  init.top
fep                       lig.fep
restart                   heat"$j".re
final                     heat"$i".re
trajectory                heat"$i".dcd

![trajectory_atoms]
!not excluded

![lambdas]
!1.000 0.000

[sequence_restraints]
1 2846 10.0 0 1
" > heat$i.inp
time mpirun -np 8 qdynp heat$i.inp > heat$i.log
done


################################################################################
# RELAXATION: A for-loop to do a smooth release of restraints
################################################################################

time mpirun -np 8 qdynp relax1.inp > relax1.log

for i in $(seq -w 1 1 5)
do
    j=$(awk 'BEGIN{printf "%2.1f", 1.201-('''$i'''*0.2)}')
    k=`expr $i "+" 1`
    echo "[MD]
steps                     1000
stepsize                  2
temperature               300.0
bath_coupling             10
shake_solvent             on
shake_hydrogens           on
shake_solute              off
lrf                       on

[cut_offs]
solute_solute             10.0
solute_solvent            10.0
solvent_solvent           10.0
q_atom                    99.0
lrf                       99.0

[sphere]
shell_force               10
shell_radius              0.8

[solvent]
radial_force              60.0
polarization              on
polarization_force        20.0

[intervals]
non_bond                  20
output                    10
energy                    0
trajectory                10

[files]
topology                  init.top
fep                       lig.fep
restart                   relax"$i".re
final                     relax"$k".re
trajectory                relax"$k".dcd

![trajectory_atoms]
!not excluded

![lambdas]
!1.000 0.000

[sequence_restraints]
1 2846 "$j" 0 1
" > relax$k.inp
time mpirun -np 8 qdynp relax$k.inp > relax$k.log
done


################################################################################
# EQUILIBRATION: After releasing the constraints the system is allowed to
# equilibrate.
################################################################################
time mpirun -np 8 qdynp equi.inp > equi.log
#qprep < equipdb.inp > equipdb.log

################################################################################
# PRODUCTION: After the system is in equilibrium a production run can be started
# for as long as desired.
################################################################################
#mpirun -np 8 qdynp prod.inp > prod.out
