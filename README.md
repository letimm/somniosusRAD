# somniosusRAD
RAD data assembly and filtering scripts. The majority of these are SLURM submission scripts.
Developed by the Larson lab, special thanks to Dr. Yue Shi.

Scripts are numbered in the order that they run:
1-sharks01_processRADtags.sh runs the process_radtags step of STACKS2.
2-ustacks_array.sh launches a job array, running all individuals through STACKS2's ustacks. It requires an additional, user-supplied file specifying the individuals. This array input file should follow the format job_id:sample_file:sample_id ("37:ABLG4027_R1.fq:ABLG4027")
3-cstacks.sh is to run STACKS2's cstacks over the output of ustacks.
4-sstacks.sh runs STACKS2's sstacks.
5-tgpstacks.sh runs the last three applicable steps of assembly in STACKS2: tsv2bam, gstacks, and populations. Be aware that you will need to remove the ".1" from the names of all files in your pop map (the file specified with the -M flag).
Finally, the vcf_filtering.sh script calls and runs vcftools to filter as described in Timm et al., 'Molecular ecology of the sleeper shark subgenus Somniosus Somniosus'
