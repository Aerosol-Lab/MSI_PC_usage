#!/bin/bash
#PBS -l walltime=01:00:00,nodes=1:ppn=1,pmem=1gb

module load python
module load conda

conda create --name env_1 --clone base
