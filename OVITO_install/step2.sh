#!/bin/bash
#PBS -l walltime=10:00:00,nodes=1:ppn=5,pmem=30gb

module load conda

conda activate env_ovito
pip uninstall -y ovito PySide2 PySide6
conda install --strict-channel-priority -c https://conda.ovito.org -c conda-forge ovito
