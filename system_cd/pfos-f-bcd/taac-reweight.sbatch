#!/bin/sh
#SBATCH -J r-bcd-pfos         # Job name
#SBATCH -o r-bcd-pfos.o%j    # Name of stdout output file
#SBATCH -e r-bcd-pfos.e%j    # Name of stderr error file
#SBATCH -p rtx	            # Queue (partition) name
#SBATCH -N 1               # Total # of nodes (must be 1 for serial)
#SBATCH -n 16               # Total # of mpi tasks (should be 1 for serial)
#SBATCH -t 02:00:00        # Run time (hh:mm:ss)
#SBATCH --mail-type=all    # Send email at begin and end of job
#SBATCH -A DMS22011        # Project/Allocation name (req'd if you have more than 1)
#SBATCH --mail-user=maxtopel@uchicago.edu


source load-gromacs.sh

source reweight.sh

