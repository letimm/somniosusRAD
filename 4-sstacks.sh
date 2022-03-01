#!/bin/bash

#SBATCH --job-name=sstacks
#SBATCH --output /home/ltimm/sharks/job_outfiles/sharks_sstacks.out
#SBATCH -e /home/ltimm/sharks/job_outfiles/sharks_sstacks.err
#SBATCH --ntasks=1
#SBATCH --cpus-per-task 18
#SBATCH --time=7-00:00:00

module unload bio/stacks/2.55
module load bio/stacks/2.55

sstacks \
	-P /home/ltimm/sharks/ustacks \
	-M /home/ltimm/sharks/sharks_sppmap_all.txt \
	-p 18 \
	--disable_gapped