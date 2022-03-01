#!/bin/bash

#SBATCH --time=7-00:00:00
#SBATCH --cpus-per-task=18
#SBATCH --job-name=prt_sh01
#SBATCH --output=/home/ltimm/sharks/job_outfiles/sharks01_processRADtags.out

module unload bio/stacks/2.55
module load bio/stacks/2.55

process_radtags \
	-1 /home/ltimm/sharks/sharks01_RAD/sharks01-RAD_R1.fq.gz \
	-2 /home/ltimm/sharks/sharks01_RAD/sharks01-RAD_R2.fq.gz \
	-b /home/ltimm/sharks/sharks01_RAD/sharks01-RAD_barcodes.txt \
	-e sbfI \
	-i gzfastq \
	--filter_illumina \
	--bestrad \
	-c \
	-q \
	-r \
	-t 140 \
	-o /home/ltimm/sharks/demultiplexed/
