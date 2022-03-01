# somniosusRAD
RAD data assembly and filtering scripts. The majority of these are SLURM submission scripts, the only excepting is vcf_retain_highestMAF.py.
Developed by the Larson lab, special thanks to Dr. Yue Shi.

1-sharks01_processRADtags.sh runs the process_radtags step of STACKS2.

2-ustacks_array.sh launches a job array, running all individuals through STACKS2's ustacks. It requires an additional, user-supplied file specifying the individuals. This array input file should follow the format job_id:sample_file:sample_id ("37:ABLG4027_R1.fq:ABLG4027")

3-cstacks.sh is to run STACKS2's cstacks over the output of ustacks.

4-sstacks.sh runs STACKS2's sstacks.

5-tgpstacks.sh runs the last three applicable steps of assembly in STACKS2: tsv2bam, gstacks, and populations. Be aware that you will need to remove the ".1" from the names of all files in your pop map (the file specified with the -M flag).


While some filtering occurs in STACKS2 during assembly, the bulk of filtering occurs with VCFtools and HDplot. (See filters described in Timm et al., 'Molecular ecology of the sleeper shark subgenus Somniosus Somniosus' for more detail.)

vcftools_filtering.sh calls VCFtools and filters the vcf on site and individual missingness, as well as minor allele frequency.

Next, the site with the highest minor allele frequency is retained using a custom python script, vcf_retain_highestMAF.py. This script takes the vcf as input and outputs a new vcf with the suffix "one-snp-per-locus.vcf".

The resulting vcf is analyzed with HDplot in R (https://github.com/gjmckinney/HDplot) and putatively paralogous loci are printed out in a "blacklist".

These blacklisted sites are removed with the vcftools_filtering_hdplot-pruning.sh script.
