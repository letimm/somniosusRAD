#!/bin/bash

#SBATCH --cpus-per-task=12
#SBATCH --time=3-00:00:00
#SBATCH --job-name=gl-vcf
#SBATCH --output=/home/ltimm/sharks/job_outfiles/greenland-stacks_vcffilter_hdplot-pruning.out

module unload bio/vcftools/0.1.16
module load bio/vcftools/0.1.16

vcftools \
	--vcf /home/ltimm/sharks/greenland-stacks/greenland-stacks_maf0.05_lmiss0.15_imiss0.50.recode_one-snp-per-locus.vcf \
	--exclude-positions /home/ltimm/sharks/greenland-stacks/greenland-stacks_HDplot_blacklist_positions.txt \
	--maf 0.05 \
	--max-missing 0.85 \
	--out /home/ltimm/sharks/greenland-stacks/greenland-stacks_maf0.05_lmiss0.15_imiss0.50_OSPL_non-singletons-pruned \
	--recode \
	--recode-INFO-all

vcftools \
	--vcf /home/ltimm/sharks/greenland-stacks/greenland-stacks_maf0.05_lmiss0.15_imiss0.50_OSPL_non-singletons-pruned.recode.vcf \
	--out /home/ltimm/sharks/greenland-stacks/greenland-stacks_FINAL \
	--missing-indv

vcftools \
	--vcf /home/ltimm/sharks/greenland-stacks/greenland-stacks_maf0.05_lmiss0.15_imiss0.50_OSPL_non-singletons-pruned.recode.vcf \
	--out /home/ltimm/sharks/greenland-stacks/greenland-stacks_FINAL \
	--missing-site

vcftools \
	--vcf /home/ltimm/sharks/greenland-stacks/greenland-stacks_maf0.05_lmiss0.15_imiss0.50_OSPL_non-singletons-pruned.recode.vcf \
	--out /home/ltimm/sharks/greenland-stacks/greenland-stacks_FINAL \
	--depth

vcftools \
	--vcf /home/ltimm/sharks/greenland-stacks/greenland-stacks_maf0.05_lmiss0.15_imiss0.50_OSPL_non-singletons-pruned.recode.vcf \
	--out /home/ltimm/sharks/greenland-stacks/greenland-stacks_FINAL \
	--site-depth

vcftools \
	--vcf /home/ltimm/sharks/greenland-stacks/greenland-stacks_maf0.05_lmiss0.15_imiss0.50_OSPL_non-singletons-pruned.recode.vcf \
	--out /home/ltimm/sharks/greenland-stacks/greenland-stacks_FINAL \
	--freq

freq_parser.py \
	-f /home/ltimm/sharks/greenland-stacks/greenland-stacks_FINAL.frq \
	-o /home/ltimm/sharks/greenland-stacks/greenland-stacks_FINAL
