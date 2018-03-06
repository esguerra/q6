library(bio3d)
pdbfile <- "../init.pdb"
dcdfile <- "../equi.dcd"
#dcdfile <- "../allstages.dcd"

pdb <- read.pdb(pdbfile)
dcd <- read.dcd(dcdfile)
ca.inds <- atom.select(pdb, elety="CA")
xyz <- fit.xyz(fixed=pdb$xyz, mobile=dcd, fixed.inds=ca.inds$xyz,
               mobile.inds=ca.inds$xyz)


rd <- rmsd(xyz[1,ca.inds$xyz], xyz[,ca.inds$xyz])

pdf(file="bio3dstats.pdf",family="Helvetica", width=10,height=6)
par(mfcol=c(1,1))
par(cex=0.6)
par(mar=c(1, 2, 0, 0), oma=c(4,4,4,2))
par(tcl=-0.25)
par(mgp=c(2,0.6,0))

simtime <- 1 #Simulation time in nanoseconds
nsteps <- dim(dcd)[1] #Number of steps
#xlim=range(0, length(rd))
xlim=range(0, simtime)
ylim=range(min(rd)*1.01,max(rd)*1.01)
yrange=abs(max(rd)*1.01-min(rd)*1.01)

plot(seq(0,simtime,simtime/nsteps)[1:nsteps],rd, type="o", col="blue",
     xlab = " ", main="", xlim = xlim, ylim = ylim, ylab= " ",
     panel.first = grid(), axes=FALSE, xaxs="i", yaxs="i", pch=18)
#lines(seq(0,simtime[1,],simtime[1,]/nout),solvent[,1],type="b",col="blue" ,xaxt="n",yaxt="n",xlab="",ylab="", pch=18)
#lines(seq(0,simtime[1,],simtime[1,]/nout),solutesolvent[,1],type="b",col="red",xaxt="n",yaxt="n",xlab="",ylab="", pch=18)
legend("topright",col=c("blue"),lty=1,legend=c("rmsd"))
axis(1, cex.axis=1.2, at=seq(0,simtime,simtime/nsteps)[1:nsteps])
axis(2, cex.axis=1.2, at=signif(seq(min(rd),max(rd)*1.01,yrange/10), digits=2),las=1)
mtext(expression(paste("RMSD ", (ring(A)))),  side=2, outer=T, cex=1.0, line=1.0, adj=0.5)
mtext("time(ns)",  side=1, outer=T, cex=1.0, line=2.5, adj=0.5)
box(which="plot",col="black")



# Inside Histogram
xmean <- mean(rd)
xsd <- sd(rd)
maxx <- max(rd)
minx <- min(rd)

xlim     <- c(xmean-(3*xsd),xmean+(3*xsd))
breaksx  <- ((maxx-minx)/100)
binsx    <- seq(minx,maxx,breaksx)
xtickx   <- seq(minx,maxx,(breaksx*10))



par("plt"=c(0.7, 0.90, 0.1, 0.50), new=T)
h1 <- hist(rd, breaks=binsx, plot=FALSE)
miny <- 0
maxy <- max(h1$counts)*1.05
xlim <- c(xmean-(3*xsd),xmean+(3*xsd))
ylim <- c(miny, maxy)
par(xaxs = "i"); par(yaxs = "i")
plot(h1, xlim=xlim, ylim=ylim, xlab=" ", main="", axes=FALSE,
     density=-1, border="red")
axis(1, cex.axis=1.0)
axis(2, cex.axis=1.0)
box(which="plot",col="blue")
par("plt"=c(0,1,0,1))

dev.off()
