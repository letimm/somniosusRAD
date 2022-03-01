#!/usr/bin/python3

import argparse
from collections import OrderedDict
import os

parser = argparse.ArgumentParser()
parser.add_argument('--vcf_in', '-v', help = 'Please provide an input vcf file.')
args = parser.parse_args()

outfile_name = ".".join(args.vcf_in.split(".")[:-1]) + "_one-snp-per-locus.vcf"
retained_snps = OrderedDict()
with open(outfile_name, 'w') as o:
	with open(args.vcf_in, 'r') as vcf:
		for raw_line in vcf:
			if raw_line.startswith("#"):
				o.write(raw_line)
			else:
				site_data = raw_line.rstrip().split('\t')
				locus = site_data[0]
				bp = site_data[1]
				allele_freq = site_data[7].split("=")[2]
				if locus not in retained_snps.keys():
					retained_snps[locus] = [allele_freq, raw_line]
				else:
					current_highest_maf = retained_snps[locus][0]
					if current_highest_maf < allele_freq:
						retained_snps[locus] = [allele_freq, raw_line]
	for snp_line in retained_snps.values():
		o.write(snp_line[1])
