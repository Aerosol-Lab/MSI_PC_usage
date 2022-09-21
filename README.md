# Hogan Lab. Minnesota Supercomputer Institute (MSI) usage
## <span style="color:blue">ssh connection</span>
Open terminal (Linux) or command prompt and connet MSI pc by typing following command:
```
ssh username@mesabi.msi.umn.edu
```
where, username is your UMN internet ID.  The system require 2-factor authentification (your UMN password and DUO).  After the authentification, your can see this login screen:
```
Success. Logging you in...
Last failed login: Tue Sep 20 09:14:30 CDT 2022 from me-u-me-pcl-18.me.umn.edu on ssh:notty
There were 2 failed login attempts since the last successful login.
Last login: Thu Sep 15 08:43:38 2022 from 10.100.0.179
-------------------------------------------------------------------------------
             University of Minnesota Supercomputing Institute
                                 Mesabi
                         HP Haswell Linux Cluster
-------------------------------------------------------------------------------
For assistance please contact us at https://www.msi.umn.edu/support/help.html
help@msi.umn.edu, or (612)626-0802.
-------------------------------------------------------------------------------
Home directories are snapshot protected. If you accidentally delete a file in
your home directory, type "cd .snapshot" then "ls -lt" to list the snapshots
available in order from most recent to oldest.

January 6, 2021: Slurm is now the scheduler for all nodes.
-------------------------------------------------------------------------------
tamad005@ln0004 [~] %
```
---
<br>
<br>

## <span style="color:blue">Job submission</span>
### Submission script
**Do NOT drectly run on turminal** but creat job script and submit it.  You can see more detail about the submission script from [here](https://www.msi.umn.edu/content/job-submission-and-scheduling-slurm). Here, just a simple example is shown:
```
#!/bin/bash
##  #SBATCH ** set
#SBATCH -time 20:00:00  # set maximum calculation time
#SBATCH --ntasks=5      # set number of cores (processers)
#SBATCH --mem=2gb       # set limit of memorry (ram) usage

module load intel       # load intel compiler module
module load ompi        # load openMPI module

icpc -O3 -o run.out src/*cpp -std=c++11   # compile src/*cpp and create run.out file
mpirun -n 5 ./run.out                     # run ./run.out with 5 cores (parallel)
```
First few lines starting from `#SBATCH` set resource which you use in this job.  Second block `module load *` load a module you use in this job.  Third block is main commands (what you do in this job).  
### Job submission & related commands
#### - Submit job script.  
```
sbatch filename
```
#### - Check simulation status
```
squeue --me
```
You can see this kind of output:
```
tamad005@ln0006 [~/TiO2/0.6nm1.6nm_5] % squeue --me
             JOBID PARTITION     NAME     USER ST       TIME  NODES NODELIST(REASON)
         150273877   agsmall   run.sh tamad005  R   21:45:16      1 acn120
         150273874   agsmall   run.sh tamad005  R   21:45:47      1 acn97
         150273875   agsmall   run.sh tamad005  R   21:45:47      1 acn38
         150273876   agsmall   run.sh tamad005  R   21:45:47      1 acn38
         150272959   agsmall   run.sh tamad005  R   21:58:45      1 acn84
         150272960   agsmall   run.sh tamad005  R   21:58:45      1 acn172
         150272961   agsmall   run.sh tamad005  R   21:58:45      1 acn172
         150272962   agsmall   run.sh tamad005  R   21:58:45      1 acn172
         150272954   agsmall   run.sh tamad005  R   21:58:46      1 acn08
         150272955   agsmall   run.sh tamad005  R   21:58:46      1 acn08
         150272956   agsmall   run.sh tamad005  R   21:58:46      1 acn08
         150272957   agsmall   run.sh tamad005  R   21:58:46      1 acn83
         150272958   agsmall   run.sh tamad005  R   21:58:46      1 acn84
         150272780   agsmall   run.sh tamad005  R   22:06:15      1 acn109
         150272781   agsmall   run.sh tamad005  R   22:06:15      1 acn21
         150272782   agsmall   run.sh tamad005  R   22:06:15      1 acn21
         150272783   agsmall   run.sh tamad005  R   22:06:15      1 acn21
         150272784   agsmall   run.sh tamad005  R   22:06:15      1 acn08
         150272774   agsmall   run.sh tamad005  R   22:06:16      1 acn130
         150272775   agsmall   run.sh tamad005  R   22:06:16      1 acn130
         150272777   agsmall   run.sh tamad005  R   22:06:16      1 acn43
         150272778   agsmall   run.sh tamad005  R   22:06:16      1 acn43
         150272779   agsmall   run.sh tamad005  R   22:06:16      1 acn43
         150272727   agsmall   run.sh tamad005  R   22:09:25      1 acn149
         ...
```
#### - Check storage usage
You can check the your storage usage by:
```
groupquota -u
```
The option -u mean your usage.  When you remove -u option, total group strage usage is displayed.  Below is example where he use 391.79 GB storage (11.3% of hogancj group storage):
```
Quota for user 'tamad005' in group 'hogancj'
------------------------
BYTES        |          
Usage        | 391.79 GB
Quota        | 3.48 TB  
Percent used | 11.3 %   
------------------------
FILES        |          
Usage        | 233,589  
Quota        | 5,000,000
Percent used | 4.7 %    
```
---
<br>
<br>

## <span style="color:blue">File transfer</span>
### 1. WinSCP (Windows)
You can find instruction from [here](https://www.msi.umn.edu/support/faq/how-do-i-use-winscp-transfer-data).
### 2. FileZilla (Linux)
You can find instruction from [here](https://www.msi.umn.edu/support/faq/how-do-i-use-filezilla-transfer-data).
### 3. SCP
Type command `scp` like `cp` in UNIX command:<br>
```
scp username@mesabi.msi.umn.edu:address1 address2
```
---
<br>
<br>

## <span style="color:blue">LAMMPS (MD simulaiton)</span>
### 1. Load module
```
module load lammps
```
### 2-1. Run with MSI execute file
Serial run:
```
lmp_intel_cpu_intelmpi -in inputFileName
```
Parallel run (substitute nCPU with your number of CPUs):
```
mpirun -n nCPU lmp_intel_cpu_intelmpi -in inputFileName
```
### 2-2. Build source code & run
Transfer src, load lammps module, and build it.
---
<br>
<br>

## <span style="color:blue">OpenFOAM (CFD simulation)</span>
You can find instruction from [here](https://www.msi.umn.edu/sw/openfoam) but it is not useful and some calculation could not run with this way due to the old version of OpenFOAM. We reccomend to build your own source code on the MSI computer and use it as following instruction.
### Build source code
#### Step 1: Download OpenFOAM
* You can obtain openfoam-OpenFOAM-v2012.tar.gz from [Hogan Lab google drive](https://drive.google.com/drive/folders/1aNexaUZE-kseBgT_6dSQ2XPvSLhlY9ph?usp=sharing) or from this [link](https://develop.openfoam.com/Development/openfoam/-/tree/OpenFOAM-v2012).
* <span style="color:red">**Newer version (OpenFOAM-v2206) could not be compiled**</span> due to maybe MSI compiler issue (check date: 08/19/2022).  The versions between v2012-v2206 and OpenFOAM foundation version may be avairable (not checked).
#### Step 2: Transfer downloaded file to MSI
* Creat a OpenFOAM directory at your MSI home directory: `mkdir ~/OpenFOAM`.
* Transfer the downloaded file to the created directory (*~/OpenFOAM/*) with compressed form (.tar.gz).
* Check you have *~/OpenFOAM/openfoam-OpenFOAM-v2012.tar.gz* file.
#### Step 3: Extract file
* Transfer [OpenFOAM_MSIscript/Extract.sh](https://github.com/tamadate/MSI_PC_usage/blob/master/OpenFOAM_MSIscript/Extract.sh) file to *~/OpenFOAM/*.
* Submit that script: `sbatch Extract.sh`
* This script extract .tar file via `tar -xfv openfoam-OpenFOAM-v2012.tar.gz`.
* Check you have *~/OpenFOAM/openfoam-OpenFOAM-v2012* file.
#### Step 4: Build
* Transfer [OpenFOAM_MSIscript/build.sh](https://github.com/tamadate/MSI_PC_usage/blob/master/OpenFOAM_MSIscript/build.sh) to *~/OpenFOAM/openfoam-OpenFOAM-v2012/*.
* Submit script by `sbatch build.sh`
* This script build OpenFOAM (10 cores parallel) via:
```
module load ompi
module load flex
source ~/OpenFOAM/openfoam-OpenFOAM-v2012/etc/bashrc
./Allwmake -j 10
```
* It may take a while (>1hr).
### Run simulation
You need to load an ompi module and bashrc files in the submission script (you can do it on the terminal before the submission but it is better to do in the submission script for just in case).  This is an test case from cavity flow in tutorial:
```
#!/bin/bash
#SBATCH -time 20:00:00
#SBATCH --ntasks=1
#SBATCH --mem=2gb

module load ompi
source ~/OpenFOAM/openfoam-OpenFOAM-v2012/etc/bashrc

cp -r ~/OpenFOAM/openfoam-OpenFOAM-v2012/tutorial/incompressible/icoFoam/cavity/cavity ./
blockMesh
icoFoam
```
---
<br>
<br>

## <span style="color:blue">Your own code</span>
Only you know how to use it.
<br>
<br>

## Author
* Dr. Tomoya Tamadate
* [LinkedIn](https://www.linkedin.com/in/tomoya-tamadate-953673142/)/[ResearchGate](https://www.researchgate.net/profile/Tomoya-Tamadate)/[Google Scholar](https://scholar.google.com/citations?user=XXSOgXwAAAAJ&hl=ja)
* University of Minnesota
* tamalab0109[at]gmail.com
