#!/bin/bash

# set the path to the STAR executable
STAR="/mnt/storage/labs/insco/squire/scripts/squire_build/STAR-2.5.3a/STAR-2.5.3a/bin/Linux_x86_64/STAR"

# Set the path to the STAR genome index directory
genome_index_dir="/mnt/storage/labs/insco/pipeline/genomes/human_genome"

# Set the path to the directory containing your data files
data_dir="/mnt/storage/labs/insco/test_HG/test_new"

outdir="/mnt/storage/labs/insco/test_HG/mapped_test_new"

# Number of threads to use
num_threads=6

forward_reads="/mnt/storage/labs/insco/test_HG/test_new/*R1.fastq.gz"

# Loop through each forward read file
for forward_reads in "${data_dir}"/*R1.fastq.gz; do
    # Extract the sample name from the forward read file name
    sample=$(basename "${forward_reads}" | sed 's/R1.fastq.gz//')
    
    # Define the path to the reverse read file based on the sample name
    reverse_reads="${data_dir}/${sample}R2.fastq.gz"

    # Create a directory for the output of this sample
    output_dir="${outdir}/${sample}mapped"
    mkdir -p "${output_dir}"

    # Run STAR alignment
    ${STAR} \
        --runThreadN ${num_threads} \
        --genomeDir "${genome_index_dir}" \
        --readFilesIn "${forward_reads}" "${reverse_reads}" \
        --readFilesCommand zcat \
 --outFileNamePrefix "${output_dir}/" \
        --outSAMtype BAM SortedByCoordinate \
 --outWigType bedGraph \
 --outWigStrand Stranded 


    

    echo "Alignment completed for ${sample}"
done
