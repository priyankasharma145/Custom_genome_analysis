

#!/bin/bash

# Input and output directories
input_dir="/mnt/storage/labs/insco/Bioinfo_for_all/raw_reads"
output_dir="/mnt/storage/labs/insco/Bioinfo_for_all/priyanka/trimmed_reads"

# Create output directory if it doesn't exist
mkdir -p "$output_dir/fastqc_analysis"

# Number of threads for parallel processing
num_threads=4

# Loop through each forward read file
for forward_reads in "${input_dir}"/*_R1_001.fastq.gz; do
    # Extract the sample name from the forward read file name
    sample=$(basename "${forward_reads}" | sed 's/_R1_001.fastq.gz//')

    # Define the path to the reverse read file based on the sample name
    reverse_reads="${input_dir}/${sample}_R2_001.fastq.gz"

    # Run cutadapt on each file
    cutadapt -j 4 -q 30 -a GATCGGAAGAGCACACGTCTGAACTCCAGTCAC -a CTGTCTCTTATACACATCT -g AGATGTGTATAAGAGACAG -A GATCGGAAGAGCGTCGTGTAGGGAAAGAGTGTAGATCTCGGTGGTCGCCGTATCATT -A CTGTCTCTTATACACATCT -G AGATGTGTATAAGAGACAG -m 50 -e 0.02 -o "$output_dir/$sample.trim_R1.fastq.gz" -p "$output_dir/$sample.trim_R2.fastq.gz" "$forward_reads" "$reverse_reads"

    # Run fastqc on trimmed files
    fastqc -o "$output_dir/fastqc_analysis" "$output_dir/$sample.trim_R1.fastq.gz" "$output_dir/$sample.trim_R2.fastq.gz"
done

