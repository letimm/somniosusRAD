#!/bin/bash

# %A is the JobID
# %a is the arrayID
#SBATCH --job-name=ustacks
#SBATCH --cpus-per-task=18
#SBATCH --output=/home/ltimm/sharks/job_outfiles/ustacks_array.%A.%a.txt
#SBATCH --time=7-00:00:00

#SBATCH --array=1-288%48

module unload bio/stacks/2.55
module load bio/stacks/2.55

BASE=/home/ltimm/sharks
JOBS_FILE=${BASE}/sharks_ustacks_jobs.txt
IDS=$(cat ${JOBS_FILE})

# Loop through the sample file and grab the entry that corresponds to 
# the current job array ID
for sample_line in ${IDS}
do 
    # Skip lines in the ID file that start with a #
    if [[ ${sample_line} == "#"* ]]; then
        continue
    fi

    # Grab the index number and sample ID
    job_index=$(echo ${sample_line} | awk -F ":" '{print $1}')
    sample_file=$(echo ${sample_line} | awk -F ":" '{print $2}')
    sample_id=$(echo ${sample_line} | awk -F ":" '{print $3}')

    # If index number matches current array ID, break (stop searching)
    # and use that id for the rest of the job
    if [[ ${SLURM_ARRAY_TASK_ID} == ${job_index} ]]; then
        break
    fi
done

ustacks \
    -t gzfastq \
    -f $sample_file \
    -o ${BASE}/ustacks \
    -i $sample_id \
    --disable-gapped \
    -m 3 \
    -M 3 \
    -H \
    -p 18 \
    --max_locus_stacks 4 \
    --model_type bounded \
    --bound_high 0.05
