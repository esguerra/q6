#2345678901234567890123456789012345678901234567890123456789012345678901234567890
################################################################################
# Property plotter for Q runs
################################################################################
# An example of the "juice" in a Q output file is in the following summary lines:
#
# =======================  Energy summary at step  24500 ========================
#   el       vdW      bond     angle   torsion  improper
# solute            -7230.75   -235.91    912.03   1328.94    531.60     64.47
# solvent           -8127.62   1396.65      0.00      0.00      0.00      0.00
# solute-solvent    -2938.63   -151.95
# LRF                -231.30
# Q-atom            -1275.33     30.90   -241.13      8.34      2.86      0.00
# 
# total       fix slvnt_rad slvnt_pol     shell    solute
# restraints          631.26    113.34   -385.36     25.87     67.21    810.21
# 
# total potential   kinetic
# SUM              -10847.32 -15525.57   4678.25
# ======================= Q-atom energies at step  24500 ========================
#   type   st lambda        el       vdW      bond     angle   torsion  improper
# Q-Q     1 1.0000    329.24     15.16
# Q-Q     2 0.0000    269.55     60.38
# 
# Q-prot  1 1.0000  -1462.79      5.45
# Q-prot  2 0.0000  -1486.59      1.64
# 
# Q-wat   1 1.0000   -141.78     10.29
# Q-wat   2 0.0000   -143.81     10.35
# 
# Q-surr. 1 1.0000  -1604.57     15.75
# Q-surr. 2 0.0000  -1630.40     11.99
# 
# Q-any   1 1.0000  -1275.33     30.90   -241.13      8.34      2.86      0.00
# Q-any   2 0.0000  -1360.85     72.37    -29.70    159.91      3.82      0.00
# 
# type   st lambda     total restraint
# Q-SUM   1 1.0000  -1474.36      0.00
# Q-SUM   2 0.0000  -1154.44      0.00
# H( 1, 2) =    0.00 dist. between Q-atoms   2  31 =    1.68
# H( 1, 2) =    0.00 dist. between Q-atoms  23  31 =    2.99
# H( 1, 2) =    0.00 dist. between Q-atoms  23  26 =    1.00
# H( 1, 2) =    0.00 dist. between Q-atoms  26  33 =    2.75
# ===============================================================================
#   Temperature at step   24500:         T_tot=     295.2         T_free=     307.4

qlog <- "../start.log"
simtime         <- grep("Number of MD steps ",readLines(qlog), value=TRUE)
solute          <- grep("^solute ",readLines(qlog), value=TRUE)
solvent         <- grep("^solvent ",readLines(qlog), value=TRUE)
solutesolvent   <- grep("^solute-solvent ",readLines(qlog), value=TRUE)
lrf             <- grep("^LRF ",readLines(qlog), value=TRUE)
qatom           <- grep("^Q-atom ",readLines(qlog), value=TRUE)
restraints      <- grep("^restraints ",readLines(qlog), value=TRUE)
total           <- grep("^SUM ",readLines(qlog), value=TRUE)
temperature     <- grep("Temperature at step",readLines(qlog), value=TRUE)

simtime       <- read.table(text = simtime)[1:(length(simtime)-1), 2:10]
simtime       <- (simtime[9]*simtime[5])/1000  #simulation time in picoseconds
solute        <- read.table(text = solute)[1:(length(solute)-1), 2:7]
solvent       <- read.table(text = solvent)[1:(length(solvent)-1), 2:7]
solutesolvent <- read.table(text = solutesolvent)[1:(length(solutesolvent)-1), 2:3]
lrf           <- read.table(text = lrf)[1:(length(lrf)-1), 2]
#qatom         <- read.table(text = qatom)[1:(length(qatom)-1), 2:7]
restraints    <- read.table(text = restraints)[1:(length(restraints)-1), 2:7]
total         <- read.table(text = total)[1:(length(total)-1), 2:4]
temperature   <- read.table(text = temperature)[1:(length(temperature)-1), 2:8]

qlog <- "allheat.out"
simtime1         <- grep("Number of MD steps ",readLines(qlog), value=TRUE)
solute1          <- grep("^solute ",readLines(qlog), value=TRUE)
solvent1         <- grep("^solvent ",readLines(qlog), value=TRUE)
solutesolvent1   <- grep("^solute-solvent ",readLines(qlog), value=TRUE)
lrf1             <- grep("^LRF ",readLines(qlog), value=TRUE)
qatom1           <- grep("^Q-atom ",readLines(qlog), value=TRUE)
restraints1      <- grep("^restraints ",readLines(qlog), value=TRUE)
total1           <- grep("^SUM ",readLines(qlog), value=TRUE)
temperature1     <- grep("Temperature at step",readLines(qlog), value=TRUE)

simtime1       <- read.table(text = simtime1)[1:(length(simtime1)-1), 2:10]
simtime1       <- (simtime1[9]*simtime1[5])/1000  #simulation time in picoseconds
solute1        <- read.table(text = solute1)[1:(length(solute1)-1), 2:7]
solvent1       <- read.table(text = solvent1)[1:(length(solvent1)-1), 2:7]
solutesolvent1 <- read.table(text = solutesolvent1)[1:(length(solutesolvent1)-1), 2:3]
lrf1           <- read.table(text = lrf1)[1:(length(lrf1)-1), 2]
#qatom1         <- read.table(text = qatom1)[1:(length(qatom1)-1), 2:7]
restraints1    <- read.table(text = restraints1)[1:(length(restraints1)-1), 2:7]
total1         <- read.table(text = total1)[1:(length(total1)-1), 2:4]
temperature1   <- read.table(text = temperature1)[1:(length(temperature1)-1), 2:8]

qlog <- "allrelax.out"
simtime2         <- grep("Number of MD steps ",readLines(qlog), value=TRUE)
solute2          <- grep("^solute ",readLines(qlog), value=TRUE)
solvent2         <- grep("^solvent ",readLines(qlog), value=TRUE)
solutesolvent2   <- grep("^solute-solvent ",readLines(qlog), value=TRUE)
lrf2             <- grep("^LRF ",readLines(qlog), value=TRUE)
qatom2           <- grep("^Q-atom ",readLines(qlog), value=TRUE)
restraints2      <- grep("^restraints ",readLines(qlog), value=TRUE)
total2           <- grep("^SUM ",readLines(qlog), value=TRUE)
temperature2     <- grep("Temperature at step",readLines(qlog), value=TRUE)

simtime2       <- read.table(text = simtime2)[1:(length(simtime2)-1), 2:10]
simtime2       <- (simtime2[9]*simtime2[5])/1000  #simulation time in picoseconds
solute2        <- read.table(text = solute2)[1:(length(solute2)-1), 2:7]
solvent2       <- read.table(text = solvent2)[1:(length(solvent2)-1), 2:7]
solutesolvent2 <- read.table(text = solutesolvent2)[1:(length(solutesolvent2)-1), 2:3]
lrf2           <- read.table(text = lrf2)[1:(length(lrf2)-1), 2]
#qatom2         <- read.table(text = qatom2)[1:(length(qatom2)-1), 2:7]
restraints2    <- read.table(text = restraints2)[1:(length(restraints2)-1), 2:7]
total2         <- read.table(text = total2)[1:(length(total2)-1), 2:4]
temperature2   <- read.table(text = temperature2)[1:(length(temperature2)-1), 2:8]

#qlog <- "../equi.out"
#simtime3         <- grep("Number of MD steps ",readLines(qlog), value=TRUE)
#solute3          <- grep("^solute ",readLines(qlog), value=TRUE)
#solvent3         <- grep("^solvent ",readLines(qlog), value=TRUE)
#solutesolvent3   <- grep("^solute-solvent ",readLines(qlog), value=TRUE)
#lrf3             <- grep("^LRF ",readLines(qlog), value=TRUE)
#qatom3           <- grep("^Q-atom ",readLines(qlog), value=TRUE)
#restraints3      <- grep("^restraints ",readLines(qlog), value=TRUE)
#total3           <- grep("^SUM ",readLines(qlog), value=TRUE)
#temperature3     <- grep("Temperature at step",readLines(qlog), value=TRUE)

#simtime3       <- read.table(text = simtime3)[1:(length(simtime3)-1), 2:10]
#simtime3       <- as.matrix(sum(simtime3[9]*simtime3[5]))/1000  #simulation time in picoseconds
#solute3        <- read.table(text = solute3)[1:(length(solute3)-1), 2:7]
#solvent3       <- read.table(text = solvent3)[1:(length(solvent3)-1), 2:7]
#solutesolvent3 <- read.table(text = solutesolvent3)[1:(length(solutesolvent3)-1), 2:3]
#lrf3           <- read.table(text = lrf3)[1:(length(lrf3)-1), 2]
#qatom3         <- read.table(text = qatom3)[1:(length(qatom3)-1), 2:7]
#restraints3    <- read.table(text = restraints3)[1:(length(restraints3)-1), 2:7]
#total3         <- read.table(text = total3)[1:(length(total3)-1), 2:4]
#temperature3   <- read.table(text = temperature3)[1:(length(temperature3)-1), 2:8]


#qlog <- "../prod.out"
#simtime4         <- grep("Number of MD steps ",readLines(qlog), value=TRUE)
#solute4          <- grep("^solute ",readLines(qlog), value=TRUE)
#solvent4         <- grep("^solvent ",readLines(qlog), value=TRUE)
#solutesolvent4   <- grep("^solute-solvent ",readLines(qlog), value=TRUE)
#lrf4             <- grep("^LRF ",readLines(qlog), value=TRUE)
#qatom4           <- grep("^Q-atom ",readLines(qlog), value=TRUE)
#restraints4      <- grep("^restraints ",readLines(qlog), value=TRUE)
#total4           <- grep("^SUM ",readLines(qlog), value=TRUE)
#temperature4     <- grep("Temperature at step",readLines(qlog), value=TRUE)

#simtime4       <- read.table(text = simtime3)[1:(length(simtime3)-1), 2:10]
#simtime4       <- as.matrix(sum(simtime3[9]*simtime3[5]))/1000  #simulation time in picoseconds
#solute4        <- read.table(text = solute3)[1:(length(solute3)-1), 2:7]
#solvent4       <- read.table(text = solvent3)[1:(length(solvent3)-1), 2:7]
#solutesolvent4 <- read.table(text = solutesolvent3)[1:(length(solutesolvent3)-1), 2:3]
#lrf4           <- read.table(text = lrf3)[1:(length(lrf3)-1), 2]
#qatom4         <- read.table(text = qatom3)[1:(length(qatom3)-1), 2:7]
#restraints4    <- read.table(text = restraints3)[1:(length(restraints3)-1), 2:7]
#total4         <- read.table(text = total3)[1:(length(total3)-1), 2:4]
#temperature4   <- read.table(text = temperature3)[1:(length(temperature3)-1), 2:8]





pdf(file="qanalyze.pdf",family="Helvetica", width=10,height=6)
par(mfrow=c(2,3))
par(cex=0.6)
par(mar=c(2, 3.5, 2, 3.5), oma=c(4,4,4,2))
par(tcl=-0.25)
par(mgp=c(2,0.6,0))

##### STARTING #####
xlim=range(0, simtime[1,])
ylim=range(min(solvent,solute,solutesolvent),max(solvent,solute,solutesolvent))
yrange=abs(max(solvent,solute,solutesolvent)-min(solvent,solute,solutesolvent))
plot(seq(0,simtime[1,],simtime[1,]/19),solute[,1], type="o", col="green",
     xlab = " ", main="", xlim = xlim, ylim = ylim, ylab= " ",
     panel.first = grid(), axes=FALSE, xaxs="i", yaxs="i", pch=18)
lines(seq(0,simtime[1,],simtime[1,]/19),solvent[,1],type="b",col="red" ,xaxt="n",yaxt="n",xlab="",ylab="", pch=18)
lines(seq(0,simtime[1,],simtime[1,]/19),solutesolvent[,1],type="b",col="blue",xaxt="n",yaxt="n",xlab="",ylab="", pch=18)
legend("topright",col=c("red","blue","green"),lty=1,legend=c("solute-solvent","solvent","solute"))
axis(1, cex.axis=1.0, at=seq(0,simtime[1,],(simtime[1,]/10)))
axis(2, at=seq(min(solvent,solute,solutesolvent),max(solvent,solute,solutesolvent),yrange/10),las=1)
box(which="plot",col="black")

xlim=range(0, simtime[1,])
ylim=range(min(solvent[,2],solute[,2],solutesolvent[,2]),max(solvent[,2],solute[,2],solutesolvent[,2]))
yrange=abs(max(solvent[,2],solute[,2],solutesolvent[,2])-min(solvent[,2],solute[,2],solutesolvent[,2]))
plot(seq(0,simtime[1,],simtime[1,]/19),solute[,2], type="o", col="green",
     xlab = " ", main="", xlim = xlim, ylim = ylim, ylab= " ",
     panel.first = grid(), axes=FALSE, xaxs="i", yaxs="i", pch=18)
lines(seq(0,simtime[1,],simtime[1,]/19),solvent[,2],type="b",col="red" ,xaxt="n",yaxt="n",xlab="",ylab="", pch=18)
lines(seq(0,simtime[1,],simtime[1,]/19),solutesolvent[,2],type="b",col="blue",xaxt="n",yaxt="n",xlab="",ylab="", pch=18)
legend("topright",col=c("red","blue","green"),lty=1,legend=c("solute-solvent","solvent","solute"))
axis(1, cex.axis=1.0, at=seq(0,simtime[1,],(simtime[1,]/10)))
axis(2, at=seq(min(solvent[,2],solute[,2],solutesolvent[,2]),max(solvent[,2],solute[,2],solutesolvent[,2]),yrange/10),las=1)
box(which="plot",col="black")

xlim=range(0, simtime[1,])
ylim=range(min(total),max(total))
yrange=abs(max(total)-min(total))
plot(seq(0,simtime[1,],simtime[1,]/19),total[,1], type="o", col="green",
     xlab = " ", main="", xlim = xlim, ylim = ylim, ylab= " ",
     panel.first = grid(), axes=FALSE, xaxs="i", yaxs="i", pch=18)
lines(seq(0,simtime[1,],simtime[1,]/19),total[,2],type="b",col="red" ,xaxt="n",yaxt="n",xlab="",ylab="", pch=18)
lines(seq(0,simtime[1,],simtime[1,]/19),total[,3],type="b",col="blue",xaxt="n",yaxt="n",xlab="",ylab="", pch=18)
legend("topright",col=c("red","blue","green"),lty=1,legend=c("total","potential","kinetic"))
axis(1, cex.axis=1.0, at=seq(0,simtime[1,],(simtime[1,]/10)))
axis(2, at=seq(min(total),max(total),yrange/10),las=1)
box(which="plot",col="black")

##### HEATING #####

xlim=range(0, simtime1[1,])
ylim=range(min(solvent1,solute1,solutesolvent1),max(solvent1,solute1,solutesolvent1))
yrange=abs(max(solvent1,solute1,solutesolvent1)-min(solvent1,solute1,solutesolvent1))
plot(seq(0,simtime1[1,],simtime1[1,]/704),solute1[,1], type="o", col="green",
     xlab = " ", main="", xlim = xlim, ylim = ylim, ylab= " ",
     panel.first = grid(), axes=FALSE, xaxs="i", yaxs="i", pch=18)
lines(seq(0,simtime1[1,],simtime1[1,]/704),solvent1[,1],type="b",col="red" ,xaxt="n",yaxt="n",xlab="",ylab="", pch=18)
lines(seq(0,simtime1[1,],simtime1[1,]/704),solutesolvent1[,1],type="b",col="blue",xaxt="n",yaxt="n",xlab="",ylab="", pch=18)
legend("topright",col=c("red","blue","green"),lty=1,legend=c("solute-solvent","solvent","solute"))
axis(1, cex.axis=1.0, at=seq(0,simtime1[1,],(simtime1[1,]/10)))
axis(2, at=seq(min(solvent1,solute1,solutesolvent1),max(solvent1,solute1,solutesolvent1),yrange/10),las=1)
box(which="plot",col="black")

xlim=range(0, simtime1[1,])
ylim=range(min(solvent1[,2],solute1[,2],solutesolvent1[,2]),max(solvent1[,2],solute1[,2],solutesolvent1[,2]))
yrange=abs(max(solvent1[,2],solute1[,2],solutesolvent1[,2])-min(solvent1[,2],solute1[,2],solutesolvent1[,2]))
plot(seq(0,simtime1[1,],simtime1[1,]/704),solute1[,2], type="o", col="green",
     xlab = " ", main="", xlim = xlim, ylim = ylim, ylab= " ",
     panel.first = grid(), axes=FALSE, xaxs="i", yaxs="i", pch=18)
lines(seq(0,simtime1[1,],simtime1[1,]/704),solvent1[,2],type="b",col="red" ,xaxt="n",yaxt="n",xlab="",ylab="", pch=18)
lines(seq(0,simtime1[1,],simtime[1,]/70.4),solutesolvent1[,2],type="b",col="blue",xaxt="n",yaxt="n",xlab="",ylab="", pch=18)
legend("topright",col=c("red","blue","green"),lty=1,legend=c("solute-solvent","solvent","solute"))
axis(1, cex.axis=1.0, at=seq(0,simtime1[1,],(simtime1[1,]/10)))
axis(2, at=seq(min(solvent1[,2],solute1[,2],solutesolvent1[,2]),max(solvent1[,2],solute1[,2],solutesolvent1[,2]),yrange/10),las=1)
box(which="plot",col="black")

xlim=range(0, simtime1[1,])
ylim=range(min(total1),max(total1))
yrange=abs(max(total1)-min(total1))
plot(seq(0,simtime1[1,],simtime1[1,]/704),total1[,1], type="o", col="green",
     xlab = " ", main="", xlim = xlim, ylim = ylim, ylab= " ",
     panel.first = grid(), axes=FALSE, xaxs="i", yaxs="i", pch=18)
lines(seq(0,simtime1[1,],simtime1[1,]/704),total1[,2],type="b",col="red" ,xaxt="n",yaxt="n",xlab="",ylab="", pch=18)
lines(seq(0,simtime1[1,],simtime1[1,]/704),total1[,3],type="b",col="blue",xaxt="n",yaxt="n",xlab="",ylab="", pch=18)
legend("topright",col=c("red","blue","green"),lty=1,legend=c("total","potential","kinetic"))
axis(1, cex.axis=1.0, at=seq(0,simtime1[1,],(simtime1[1,]/10)))
axis(2, at=seq(min(total1),max(total1),yrange/10),las=1)
box(which="plot",col="black")


alltemps <- temperature1
xlim=range(1, length(alltemps[,3]))
ylim=range(min(alltemps[,5]),max(alltemps[,5]))
yrange=abs(max(alltemps[,5])-min(alltemps[,5]))
plot(seq(1,length(alltemps[,3])),alltemps[,5], type="o", col="red",
     xlab = " ", main="", xlim = xlim, ylim = ylim, ylab= " ",
     panel.first = grid(), axes=FALSE, xaxs="i", yaxs="i", pch=18)
lines(seq(1,length(alltemps[,3])),alltemps[,7],type="b",col="blue" ,xaxt="n",yaxt="n",xlab="",ylab="", pch=18)
legend("topright",col=c("red","blue"),lty=1,legend=c("total","free"))
axis(1, cex.axis=1.0)
#axis(1, cex.axis=1.0, at=seq(0 , length(alltemps[,3]), 20) , labels=round(seq(0.00,5.05,0.102),2))
axis(2, at=seq(min(alltemps[,5]),max(alltemps[,5]),yrange/10),las=1)
box(which="plot",col="black")

alltemps <- temperature2
xlim=range(1, length(alltemps[,3]))
ylim=range(min(alltemps[,5]),max(alltemps[,5]))
yrange=abs(max(alltemps[,5])-min(alltemps[,5]))
plot(seq(1,length(alltemps[,3])),alltemps[,5], type="o", col="red",
     xlab = " ", main="", xlim = xlim, ylim = ylim, ylab= " ",
     panel.first = grid(), axes=FALSE, xaxs="i", yaxs="i", pch=18)
lines(seq(1,length(alltemps[,3])),alltemps[,7],type="b",col="blue" ,xaxt="n",yaxt="n",xlab="",ylab="", pch=18)
legend("topright",col=c("red","blue"),lty=1,legend=c("total","free"))
axis(1, cex.axis=1.0)
#axis(1, cex.axis=1.0, at=seq(0 , length(alltemps[,3]), 20) , labels=round(seq(0.00,5.05,0.102),2))
axis(2, at=seq(min(alltemps[,5]),max(alltemps[,5]),yrange/10),las=1)
box(which="plot",col="black")



#par(las=0)
mtext("Electrostatic Energy(kcal/mol)",  side=2, outer=T, cex=0.6, line=2.0, adj=0.84)
mtext("Time(ps)",  side=1, outer=T, cex=0.6, line=-21.0, adj=0.15)
mtext("VdW Energy(kcal/mol)",  side=2, outer=T, cex=0.6, line=-24, adj=0.84)
mtext("Time(ps)",  side=1, outer=T, cex=0.6, line=-21.0, adj=0.50)
mtext("Energy(kcal/mol)",  side=2, outer=T, cex=0.6, line=-50, adj=0.84)
mtext("Time(ps)",  side=1, outer=T, cex=0.6, line=-21.0, adj=0.85)

mtext("Temperature(Kelvin)",  side=2, outer=T, cex=0.6, line=2.0, adj=0.15)
mtext("Time(ps)",  side=1, outer=T, cex=0.6, line=0.0, adj=0.15)



dev.off()



