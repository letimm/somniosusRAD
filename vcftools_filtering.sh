#!/bin/bash

#SBATCH --cpus-per-task=12
#SBATCH --time=3-00:00:00
#SBATCH --job-name=gl-vcf
#SBATCH --output=/home/ltimm/sharks/job_outfiles/greenland-stacks_vcffilter_final-maf0.05-lmiss0.10-0.15-imiss0.50.out

module unload bio/vcftools/0.1.16
module load bio/vcftools/0.1.16

echo "Part 1: build species-specific VCF while removing unsalvageable [max-missing] and invariant [maf] sites"
vcftools \
	--vcf /home/ltimm/sharks/greenland-stacks/greenland-stacks.snps.vcf \
	--maf 0.0001 \
	--max-missing 0.015 \
	--out /home/ltimm/sharks/greenland-stacks/greenland-stacks \
	--recode \
	--recode-INFO-all

vcftools \
	--vcf /home/ltimm/sharks/greenland-stacks/greenland-stacks.recode.vcf \
	--out /home/ltimm/sharks/greenland-stacks/greenland-stacks \
	--missing-indv

awk '$5 > 0.95' \
	/home/ltimm/sharks/greenland-stacks/greenland-stacks.imiss > \
	/home/ltimm/sharks/greenland-stacks/greenland-stacks_imiss0.95.txt


echo "\n\nPart 2: remove unsalvageable individuals"
vcftools \
	--vcf /home/ltimm/sharks/greenland-stacks/greenland-stacks.recode.vcf \
	--remove /home/ltimm/sharks/greenland-stacks/greenland-stacks_imiss0.95.txt \
	--maf 0.0001 \
	--max-missing 0.015 \
	--out /home/ltimm/sharks/greenland-stacks/greenland-stacks_imiss0.95 \
	--recode \
	--recode-INFO-all


echo "\n\nPart 3: filter by MAF"
vcftools \
	--vcf /home/ltimm/sharks/greenland-stacks/greenland-stacks_imiss0.95.recode.vcf \
	--maf 0.05 \
	--max-missing 0.015 \
	--out /home/ltimm/sharks/greenland-stacks/greenland-stacks_imiss0.95_maf0.05 \
	--recode \
	--recode-INFO-all


echo "\n\nPart 4: filter by site missingness (0.15 missing data allowed)"
vcftools \
	--vcf /home/ltimm/sharks/greenland-stacks/greenland-stacks_imiss0.95_maf0.05.recode.vcf \
	--maf 0.05 \
	--max-missing 0.85 \
	--out /home/ltimm/sharks/greenland-stacks/greenland-stacks_imiss0.95_maf0.05_lmiss0.15 \
	--recode \
	--recode-INFO-all

vcftools \
	--vcf /home/ltimm/sharks/greenland-stacks/greenland-stacks_imiss0.95_maf0.05_lmiss0.15.recode.vcf \
	--out /home/ltimm/sharks/greenland-stacks/greenland-stacks_imiss0.95_maf0.05_lmiss0.15 \
	--missing-indv

awk '$5 > 0.5' \
	/home/ltimm/sharks/greenland-stacks/greenland-stacks_imiss0.95_maf0.05_lmiss0.15.imiss > \
	/home/ltimm/sharks/greenland-stacks/greenland-stacks_imiss0.95_maf0.05_lmiss0.15_imiss0.50.txt


echo "\n\nPart 5: filter by individual missingness"
echo "lmiss 0.15"
vcftools \
	--vcf /home/ltimm/sharks/greenland-stacks/greenland-stacks_imiss0.95_maf0.05_lmiss0.15.recode.vcf \
	--remove /home/ltimm/sharks/greenland-stacks/greenland-stacks_imiss0.95_maf0.05_lmiss0.15_imiss0.50.txt \
	--maf 0.05 \
	--max-missing 0.85 \
	--out /home/ltimm/sharks/greenland-stacks/greenland-stacks_maf0.05_lmiss0.15_imiss0.50 \
	--recode \
	--recode-INFO-all

vcftools \
	--vcf /home/ltimm/sharks/greenland-stacks/greenland-stacks_maf0.05_lmiss0.15_imiss0.50.recode.vcf \
	--out /home/ltimm/sharks/greenland-stacks/greenland-stacks_maf0.05_lmiss0.15_imiss0.50 \
	--missing-indv

vcftools \
	--vcf /home/ltimm/sharks/greenland-stacks/greenland-stacks_maf0.05_lmiss0.15_imiss0.50.recode.vcf \
	--out /home/ltimm/sharks/greenland-stacks/greenland-stacks_maf0.05_lmiss0.15_imiss0.50 \
	--missing-site

vcftools \
	--vcf /home/ltimm/sharks/greenland-stacks/greenland-stacks_maf0.05_lmiss0.15_imiss0.50.recode.vcf \
	--out /home/ltimm/sharks/greenland-stacks/greenland-stacks_maf0.05_lmiss0.15_imiss0.50 \
	--depth

vcftools \
	--vcf /home/ltimm/sharks/greenland-stacks/greenland-stacks_maf0.05_lmiss0.15_imiss0.50.recode.vcf \
	--out /home/ltimm/sharks/greenland-stacks/greenland-stacks_maf0.05_lmiss0.15_imiss0.50 \
	--site-depth

vcftools \
	--vcf /home/ltimm/sharks/greenland-stacks/greenland-stacks_maf0.05_lmiss0.15_imiss0.50.recode.vcf \
	--out /home/ltimm/sharks/greenland-stacks/greenland-stacks_maf0.05_lmiss0.15_imiss0.50 \
	--freq

freq_parser.py \
	-f /home/ltimm/sharks/greenland-stacks/greenland-stacks_maf0.05_lmiss0.15_imiss0.50.frq \
	-o /home/ltimm/sharks/greenland-stacks/greenland-stacks_maf0.05_lmiss0.15_imiss0.50


echo "\n\nThe function has gone well."
