Qsource development.
================================================================================

This a fork of **Q** (Version 6) with a large amount of differences from that
original code.   
**--Use at your own risk.--**

The forked code is released under a GNU General Public License, Version 2.0
(GPLv2), that means that all modifications done here belong to the 
Public license owners, that is, Paul Bauer, j. marelius, j. aqvist,
s. c. l. kamerlin.


Status
------

[![Build Status](https://img.shields.io/travis/esguerra/q6/master.svg?style=plastic)](https://travis-ci.org/esguerra/q6)


Aim
---

The main idea of this fork is to aim for clean and readable **Q** code.  
The code is in the process of being reorganized and cleaned-up
according to best coding practices.  


Compilation
-----------

You will need to install a current version of fortran, and if you want
to use the parallel version you will also need to have an MPI
installation in your computer. We compile the code regularly with
intel-fortran and with gnu-fortran. Because of this we recommend to
compile using the GNU Compiler Collection (GCC) in as current a
version as possible. The following compilation example has been tested
in Fedora28:

    sudo dnf install gcc-gfortran libgfortran-static openmpi openmpi-devel git  
    module load mpi/openmpi-x86_64  
    git clone https://github.com/esguerra/q6.git  
	cd q6/src  
    make all COMP=gcc  
	make mpi COMP=gcc  

Also, note that the repository is connected to Docker and TravisCI,
so, you can take a look there to see what's working. Since TravisCI is
ubuntu based and we like to test in the RedHat family, we need to go
through our own docker container.


Developer Docs
--------------

We are starting to document the code using doxygen and FORD.   
Obviously you will need to install doxygen and or FORD (ver. 6.0.0)
first in order to generate the documentation.

To generate the doxygen documentation do:  

    cd docs/developers  
    doxygen DoxygenConfigFortran  


To generate the FORD (version >= 6.0.0) docs:  
    
    cd docs/developers  
    ford -d ../../src -o devdocs forddocs.md  

The compiled developers documentation with the very useful UML-type,
sort-of, graphs which FORD makes can be found at:  

<http://qdyn.no-ip.org/developers/devdocs/index.html>


Coding Standards
----------------

We are following the example of the **GROMACS** developers which have
identified the following important main points for taking into account
when organizing a molecular dynamics code.  

1.  **Code formatting** - code indentation, start and end of
    subroutines and functions, module writing.
2.  **Code constructs** - argument order, return values, encapsulation
    using abstract data types  
3.  **Interfaces** - an Application Programming Interface  
4.  **Comments in code** - comments in code that FORD can use  
5.  **Compilation** - using different hardware  
6.  **Allowed Fortran Features**  
7.  **Error Handling**  
8.  **Benchmarking**  
9.  **Accuracy Testing**   

A good example which has advanced quite nicely on the use of modern
FORTRAN is the fluidity project. A good example to draw inspiration
from.

  
1. Code formatting
------------------

* No tabs, spaces only.  
* Two spaces for indentation of each level.  
* No more than 80 characters to allow for easy code visualization
  across editors and screens. Specially important for easy mobile
  device coding, reading.  
* No trailing whitespaces. They are not seen by default in most
  editors but still count as changes in git.  
* Column 36 for : on variable declaration.  


2. Code constructs
------------------
*to do*  


3. Interfaces
-------------
*to do*  


4. Comments in code
-------------------

We are using FORD. The main rule is to include the documentation after
the program, module, function, or subroutine is started. It should be
included by using a double exclamation mark:  

    subroutine riemannhypothesis(s)
    !! This way **FORD** will find it.
	!! using double exclamation mark. It will understant markdown.
	

5. Compilation
--------------

5.1  gfortran from gcc
----------------------
At the moment this fork includes a few features of the fortran
2008 standard. The fortran 2008 standard is the latest fortran
standard. Work is being done on the fortran 2015 standard but it is
not yet released. Many features of fortran 2008 are already included
in the GNU-Compiler-Collection gfortran.

- For compiling **Q** a relatively new version of gfortran is recommended,
at least  gfortran 4.8. The  idea is  to make **Q**  an example of  a code
which integrates the latest niceties of modern *FORTRAN*.

- **Fortran 2008**(New Features)  
Coarrays for parallel computing.  
Possibility to use submodules, and submodules of submodules. Of help
for very large programs.  
*do concurrent*  

5.2 compilation in windows 10
-----------------------------

The easiest way to compile **Q** in Windows 10 without buying the whole
costly Microsoft Developers Studio is by using GCC.
To install GCC natively in Windows 10 one can use MinGW. Some easy to
follow instructions are found here:   

<http://www.codebind.com/cprogramming/install-mingw-windows-10-gcc/>

Once the basic MinGW is installed it's important to install additional
packages such as **make**. Then you can just download the **Q** code
from this repository as a .zip file and uncompress it in
the folder where you want to install **Q**.

With MinGW installed one can then open the Windows Power Shell and
compile. It's probable that make won't be in your path, so you can 
invoke it directly if you don't want to add it to your path. If you've
let the installation of MinGW proceed in the standard way the path to
make should be as shown in the following example:

    cd .\q6\src\
	C:\MinGW\bin\mingw32-make.eke all COMP=gcc

Since the makefile is made to comply with linux commands, it will not
be able to move the binaries *qprep*, *qcalc*, *qdum*, *qdyn*, *qfep*
to an independent folder. This you will have to do manually.

We have tested with gcc 6.3.0 and the compilation works well. For
compilation of the parallel *qdynp* you will need MPI in windows. We
have not tested Windows MPI yet, nor the openMPI port for cygwin.

You can find our binaries for windows 10 in the release 6.0.1 area of
the repository.


6. Allowed Fortran Features
---------------------------
Those which comply with Fortran 2008


7. Error Handling
-----------------
This is one of the weakest points of the code and it's a much pending
part.


8. Benchmarking
---------------
*to do*  


9. Accuracy Testing
-------------------
For this we use the tests available in the tests folder.

*to do* The results should be compared with similar cases in gromacs and
charmm, for example.



