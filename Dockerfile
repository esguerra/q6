FROM fedora

MAINTAINER mauricioesguerra <mauricio.esguerra@gmail.com>

RUN dnf -y update 
RUN dnf -y install gcc-gfortran openmpi openmpi-devel git
RUN dnf clean all

RUN git clone https://github.com/esguerra/Q6.git /root/Q6
RUN cd /root/Q6/src
