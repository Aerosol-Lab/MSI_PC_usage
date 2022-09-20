#!/bin/bash
#SBATCH --ntasks=10
#SBATCH --mem=20gb
#SBATCH --time 20:00:00

module load ompi
module load flex
source ~/OpenFOAM/openfoam-OpenFOAM-v2012/etc/bashrc
./Allwmake -j 10
