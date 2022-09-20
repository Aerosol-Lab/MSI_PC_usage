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
## <span style="color:blue">Job submission</span>
### Submission script
**Do NOT drectly run on turminal** but creat job script and submit it.  You can see detail about the submission script from [here](https://www.msi.umn.edu/content/job-submission-and-scheduling-slurm). A simple example is also shown here:
```
#!/bin/bash
#SBATCH -time 20:00:00
#SBATCH --ntasks=5
#SBATCH --mem=2gb

module load intel
module load ompi

icpc -O3 -o run.out src/*cpp -std=c++11
mpirun -n 5 ./run.out
```
First few lines starting from `#SBATCH` set resource which you use in this job.
* `--time` set maximum calculation time
* `--ntasks` set number of cores (processers)
* `--mem` set maximum limit of memorry (ram) usage

Second block `module load *` load a module you use in this job.  For example `module load lammps` is needed to call when you run MD simulation on LAMMPS.

Third block is main commands (what you do in this job).  In this example, `icpc -O3 -o run.out src/*cpp -std=c++11` compiles the source code and `mpirun -n 5 ./run.out` runs the compiled code with 5 cores.
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
JOBID PARTITION     NAME     USER ST       TIME  NODES NODELIST(REASON)
150233376   agsmall wmake.sh tamad005  R      15:37      1 acn02
```
#### - Check storage usage
You can check the your storage usage by:
```
groupquota -u
```
The option -u mean your usage.  When you remove -u option, total group strage usage is displayed.  This is example of the output.  He use 391.79 GB storage (11.3% of hogancj group storage):
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
## <span style="color:blue">LAMMPS (MD simulaiton)</span>
### 1. Load module
```
lmp_intel_cpu_intelmpi -in inputFileName
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
---
## <span style="color:blue">OpenFOAM (CFD simulation)</span>
You can find instruction from [here](https://www.msi.umn.edu/sw/openfoam) but it is not useful and many simulation did not run with this way since the version is old (compatibility with recent version is low). We reccomend to build your own source code on the MSI computer as following instruction.
### Build source code
#### Step 1: Download OpenFOAM
* You can obtain openfoam-OpenFOAM-v2012.tar.gz from [Hogan Lab google drive](https://drive.google.com/drive/folders/1aNexaUZE-kseBgT_6dSQ2XPvSLhlY9ph?usp=sharing) or you can download from [here](https://develop.openfoam.com/Development/openfoam/-/tree/OpenFOAM-v2012).
* <span style="color:red">**Newer version (OpenFOAM-v2206) could not be compiled**</span> due to maybe MSI compiler issue (check date: 08/19/2022).  I did not test the versions between v2206 and v2012.  OpenFOAM foundation version may be avairable as well (not checked).
#### Step 2: Transfer downloaded file to MSI
* Creat a OpenFOAM directory at your MSI home directory: `mkdir ~/OpenFOAM`.
* Transfer the downloaded file with compressed form.
* Check you have ~/OpenFOAM/openfoam-OpenFOAM-v2012.tar.gz file.
#### Step 3: Extract file on MSI
* Transfer OpenFOAM_MSIscript/Extract.sh file to ~/OpenFOAM/.
* Submit that script: `sbatch Extract.sh`
* This script extract .tar file via `tar -xfv openfoam-OpenFOAM-v2012.tar.gz`.
* Check you have ~/OpenFOAM/openfoam-OpenFOAM-v2012 file.
#### Step 4: Build
* Transfer OpenFOAM_MSIscript/build.sh to ~/OpenFOAM/openfoam-OpenFOAM-v2012/.
* Submit script by `sbatch build.sh`
* This script build OpenFOAM via:
```
module load ompi
module load flex
source ~/OpenFOAM/openfoam-OpenFOAM-v2012/
./Allwmake
```
* It may take a while (>10hr).
## <span style="color:blue">Your own code</span>
Only you know how to use it.
## Author
* Dr. Tomoya Tamadate
* [LinkedIn](https://www.linkedin.com/in/tomoya-tamadate-953673142/)/[ResearchGate](https://www.researchgate.net/profile/Tomoya-Tamadate)/[Google Scholar](https://scholar.google.com/citations?user=XXSOgXwAAAAJ&hl=ja)
* University of Minnesota
* tamalab0109[at]gmail.com
