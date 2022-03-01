#!/bin/bash

#SBATCH --job-name=cstacks
#SBATCH --output /home/ltimm/sharks/job_outfiles/sharks_cstacks.out
#SBATCH -e /home/ltimm/sharks/job_outfiles/sharks_cstacks.err
#SBATCH --ntasks=1
#SBATCH --cpus-per-task 18
#SBATCH --time=7-00:00:00

module unload bio/stacks/2.55
module load bio/stacks/2.55

cstacks \
	-P /home/ltimm/sharks/ustacks \
	-M /home/ltimm/sharks/sharks_sppmap_cstacks.txt \
	-n 3 \
	-p 18 \
	--disable_gapped
