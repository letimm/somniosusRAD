#!/bin/bash

#SBATCH --job-name=tgpstacks
#SBATCH --partition=himem
#SBATCH --output /home/ltimm/sharks/job_outfiles/sharks_TGPstacks.out
#SBATCH -e /home/ltimm/sharks/job_outfiles/sharks_TGPstacks.err
#SBATCH --ntasks=1
#SBATCH --cpus-per-task 24
#SBATCH --time=7-00:00:00

module unload bio/stacks/2.55
module load bio/stacks/2.55

tsv2bam \
	-P /home/ltimm/sharks/ustacks \
	-M /home/ltimm/sharks/sharks_sppmap_all-no1.txt \
	-R /home/ltimm/sharks/demultiplexed \
	-t 24

gstacks \
	-P /home/ltimm/sharks/ustacks \
	-M /home/ltimm/sharks/sharks_sppmap_all-no1.txt \
	-t 24

populations \
	-P /home/ltimm/sharks/ustacks \
	-M /home/ltimm/sharks/sharks_sppmap_all-no1.txt \
	-R 0.3 \
	-O /home/ltimm/sharks/stacks/populations \
	-t 24 \
	--vcf \
	--genepop