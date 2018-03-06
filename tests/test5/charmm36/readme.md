Notes on translating CHARMM36 to Q format 
================================================================================

In this folder we are building the common CHARMM-AMBER benchmark for
DHFR using the translation of the CHARMM36 protein force-field to Q.

Notice that the pdb file has to be edited in the following way.

CD in ILE has to be changed to CD1

In CHARMM the force-field is specified using two files, a so-called
topology file:
.top
and a parameter file:
.par



Issues
--------------------------------------------------------------------------------

Here is a description of issues on translation using Geir Isakseen's
script and what has been done to solve them.

{ALA} has additional, non-existing,  C-N bond defined.


The {CYX} residue name is used to describe the topology of a cysteine
involved in disulphide (S-S) bridges.
For some reason the numbering goes wrong when the additional HG1 which
bonds to SG is removed so that a "dangling bond" is created for a
possible S-S bond. The only change needed is to renumber.

WRONG
8  SG     SM          -0.08  !   O=C
10 C      C            0.51  !     |
11 O      O           -0.51

RIGHT
8  SG     SM          -0.08  !   O=C
9  C      C            0.51  !     |
10 O      O           -0.51

And also getting rid of an additional bond:

!       C      N


{CCYX} has also got to be fixed accordingly. It also gets an
additional CN bond that has to be commented out.

WRONG
 8 SG     SM          -0.08  ! OT1=C
10 C      CC           0.34  !     |
11 OT1    OC          -0.67  !     OT2(-)
12 OT2    OC          -0.67

RIGHT
 8 SG     SM          -0.08  ! OT1=C
 9 C      CC           0.34  !     |
10 OT1    OC          -0.67  !     OT2(-)
11 OT2    OC          -0.67

{CGLH} also has a numbering issue. And also an additional C N bond is added.
14 C      CC           0.34
16 HE2    H            0.44
17 OT1    OC          -0.67
18 OT2    OC          -0.67

{CGLN} has the additional C N issue.

{CLYN} Issue with numbering.

{LYN} Issue with numbering.

{NALA} Issue with numbering.
1 N      NH3         -0.30
3 CA     CT1          0.21  ! HT2   HT3

Numbering issue present in ALL {NXXX} residues.

{NCYX} has two numbering issues.

{NCYX}            !charge: 1.0 || CYX N-terminal (standard)
[atoms]
1 N      NH3         -0.30  ! HT2   HT3
3 CA     CT1          0.21  !    \ /
4 HA     HB1          0.10  ! HT1-N(+)
5 CB     CT2         -0.10
6 HB1    HA2          0.09
7 HB2    HA2          0.09
8 SG     SM          -0.08
10 C      C            0.51
11 O      O           -0.51
12 HT1    HC           0.33
13 HT2    HC           0.33
14 HT3    HC           0.33


{NGLY}  Glycine N-terminus wrong charge on CA, see GLYP on original
file. Various problems there. Wrongly defined charge groups.
Additional wrong
10 HA    HB1

{NGLY}            !charge: 1.2 || GLY N-terminal (standard)
[atoms]
    1 N      NH3         -0.30  ! HT2   HT3
    2 CA     CT1          0.13  !    \ /
    3 HA1    HB2          0.09  ! HT1-N(+)
    4 HA2    HB2          0.09  !     |
    5 C      C            0.51  !     |
    6 O      O           -0.51  !     |
    7 HT1    HC           0.33  ! HA1-CA-HA2
    8 HT2    HC           0.33  !     |
    9 HT3    HC           0.33  !     |
   10 HA     HB1          0.10  !     C=O
[bonds]                         !     |
N      CA
C      CA
!       C      N
CA     HA1
CA     HA2
O      C
HT1    N
HT2    N
HT3    N
[connections]
tail C
[impropers]
C      CA     +N     O
[charge_groups]
N     HT1   HT2   HT3   CA    HA
C     O


{NPRO}  PROP special patch in charmm
N here has special atom type NP, not NH3, accordingly charge is wrong.
The usual NTER is not used here, so there are no HT1 HT2 nor HT3 atom
types.
So, bonds and charge groups have to be fixed.
CA is atom type CP1, not CT1

{nALA} Numbering issue again.

All {nXXX} have the numbering issue.

{nGLY} Have to look in the note of NNEU where it says that gly is a
special case, where CT2 has to be used as atom type for CA. And also
the HA in NNEU is not needed here. Using charge 0.13 for CT2.

{nPRO} is also special in CHARMM. Charge groups are off


Analysis
--------------------------------------------------------------------------------

To analyze do:  

    cd rscript
    ./catandR.sh
    open qanalyze.pdf
    
 
The protocol used here does a smooth heating from 0.1 to 300 degrees Kelvin
keeping a force-constant restraint of 10 kcal/mol in all sequence residues and
then a relaxation of such restraints from 10 kcal/mol to no restraints.

Equilibration (Heat, Relax, Equilibrate)
--------------------------------------------------------------------------------

### Step1 (start.inp)
 - 10000 steps / 0.1 fs ea. = 1ps
 - initial temp = 0.1
 - final temp = 0.1
 - bath coupling 0.1
 - hydrogen shake off
 - Local Reaction Field as Taylor expansion = on


### Step2 (heat1.inp)
 - 10000 steps / 1.0 fs ea. = 10ps
 - initial temp = 0.1
 - final temp = 50
 - bath coupling 1
 - hydrogen shake off
 - Local Reaction Field as Taylor expansion = on


### Step3 to 7 (heat[2-6].inp)
 - 1000 steps / 2.0 fs ea. = 2ps per step
 - temp = increments of 50 until 300
 - bath coupling 10
 - hydrogen shake on
 - Local Reaction Field as Taylor expansion = on


### Step4 (relax[1-6].inp)
 - 1000 steps / 2.0 fs ea. = 2ps per step
 - temp = 300
 - bath coupling 10
 - hydrogen shake on
 - Local Reaction Field as Taylor expansion = on


### Step5 (equi.inp)
 - 500000 steps / 2.0 fs ea. = 1000ps
 - temp = 300
 - bath coupling 50
 - hydrogen shake on
 - Local Reaction Field as Taylor expansion = on



Benchmarks
--------------------------------------------------------------------------------


|  Machine     | Compiler    | Comp. time (min) | Sim. time (ns) | Num Proc. |    Date    |
|:-------------|:-----------:|:----------------:|:--------------:|:---------:|:----------:|
| csb          | ifort       | 00.00            |      0.00      |   8       | 2014-05-22 |
| triolith     | ifort       | 00.00            |      0.00      |   8       | 2014-XX-XX |
| tintin       | ifort       | 00.00            |      0.00      |   8       | 2014-XX-XX |
| csb          | gcc         | 00.00            |      0.00      |   8       | 2014-XX-XX |
| triolith     | gcc         | 00.00            |      0.00      |   8       | 2014-XX-XX |
| tintin       | gcc         | 00.00            |      0.00      |   8       | 2014-XX-XX |


TODO
--------------------------------------------------------------------------------

The following to-do list highlights what needs to be done for expanding the benchmark into
something useful.

- [ ] Make a script that will send runs of 1, 2, 3, 4, 5ns runs to different cluster nodes
at the same time.
- [ ] Make script with number of processors as a gradient.
- [x] Make a markdown document describing the test.
- [x] Make a general R script for plotting and making statistics with the benchmarks.
  
    
    
    
    

