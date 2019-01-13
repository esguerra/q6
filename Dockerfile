FROM fedora:28

MAINTAINER mauricioesguerra <mauricio.esguerra@gmail.com>

RUN dnf -y update 
RUN dnf -y install make gcc-gfortran libgfortran-static openmpi openmpi-devel git
RUN dnf clean all

RUN git clone https://github.com/esguerra/q6.git /root/q6
RUN cd /root/q6/src
RUN pwd
RUN module load mpi/openmpi-x86_64
RUN make all COMP=gcc
RUN make mpi COMP=gcc
RUN cd ../tests/test1
RUN ./run_test_mpi.sh


