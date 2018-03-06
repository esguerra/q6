#!/bin/bash
#set -x
#trap read debug
module load gcc/6.2.0
export bindir=/home/esguerra/software/qsource/bin
export numproc="16"

$bindir/qprep < generate.inp > generate.log
time mpirun -np $numproc $bindir/qdynp start.inp > start.log

################################################################################
# HEATING: For loop for smooth heating to 300K
################################################################################
time mpirun -np $numproc $bindir/qdynp heat1.inp > heat1.log
for i in $(seq -w 2 1 6)
do
        j=`expr $i "-" 1`
        k=`expr $i "+" 1`
        l=`expr $i "*" 50`
        m=`expr $l "-" 50` 	
echo "[MD]
steps                     1000
stepsize                  1
temperature               "$l"
bath_coupling             10
random_seed               "$RANDOM"
initial_temperature       "$m"
shake_solute              off
shake_solvent             on
lrf                       on

[cut_offs]
solute_solute             10
solute_solvent            10
solvent_solvent           10
q_atom                    99
lrf                       99

[sphere]
shell_force               10
shell_radius              0.8

[intervals]
non_bond                  20
output                    10
energy                    0
trajectory                10

[files]
topology                  init.top
fep                       protein.fep
restart                   heat"$j".re
final                     heat"$i".re
trajectory                heat"$i".dcd

[sequence_restraints]
1 2486 0.5 0 1
" > heat$i.inp
time mpirun -np $numproc $bindir/qdynp heat$i.inp > heat$i.log
done


################################################################################
# RELAXATION (For loop for smooth release of restraints)
################################################################################

time mpirun -np $numproc $bindir/qdynp relax1.inp > relax1.log

for i in $(seq -w 1 1 6)
do
    j=$(awk 'BEGIN{printf "%2.1f", 1.201-('''$i'''*0.2)}')
    k=`expr $i "+" 1`
    echo "[MD]
steps                     1000
stepsize                  1
temperature               300
bath_coupling             10
random_seed               "$RANDOM"
initial_temperature       300
shake_solute              off
shake_solvent             on
lrf                       on

[cut_offs]
solute_solute             10
solute_solvent            10
solvent_solvent           10
q_atom                    99
lrf                       99

[sphere]
shell_force               10
shell_radius              0.8

[intervals]
non_bond                  20
output                    10
energy                    0
trajectory                10

[files]
topology                  init.top
fep                       protein.fep
restart                   relax"$i".re
final                     relax"$k".re
trajectory                relax"$k".dcd

[sequence_restraints]
1 2486 "$j" 0 1
" > relax$k.inp
time mpirun -np $numproc $bindir/qdynp relax$k.inp > relax$k.log
done


time mpirun -np $numproc $bindir/qdynp equi.inp > equi.log 
#time mpirun -np $numproc qdynp prod.inp > prod.log 

