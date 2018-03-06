#!/bin/bash
cat ../heat[1-6].log > allheat.out
cat ../relax[1-9].log > allrelax.out
R CMD BATCH --no-save --no-restore heatequi.R


if [ ! -f "../allstages.dcd" ];
then
    cd ..
    catdcd -o allstages.dcd  start.dcd heat1.dcd heat2.dcd heat3.dcd heat4.dcd heat5.dcd \
    heat6.dcd relax1.dcd relax2.dcd relax3.dcd relax4.dcd relax5.dcd relax6.dcd equi.dcd
    cd . ;
fi

R CMD BATCH --no-save --no-restore bio3dstats.R

#rm *.Rout


