

#!/bin/bash

# Input directory containing sorted BAM files
input_dir="/mnt/storage/labs/insco/pipeline/mapping/mapped_data_z18/sorted_bams"

# Output directory for StringTie results
output_dir="/mnt/storage/labs/insco/pipeline/mapping/mapped_data_z18/sorted_bams/gene_counts"

gff_reference="/mnt/storage/labs/insco/pipeline/genomes/custom_genome_dr/Danio_rerio.GRCz11.105.custom.gtf"

# Make sure the output directory exists
mkdir -p "$output_dir"

# Loop through sorted BAM files
for bam_file in "$input_dir"/*.bam; do
    # Extract file name (excluding extension and path)
    base_name=$(basename "$bam_file" .bam)

    # Output GTF and abundances file names
    gtf_output="$output_dir/${base_name}_output.gtf"
    abundances_output="$output_dir/${base_name}_output_abundances.tab"

    # Run stringtie
    stringtie -t -B --rf -e -p 6 -G "$gff_reference" -o "$gtf_output" -A "$abundances_output" "$bam_file"

    echo "StringTie completed for $bam_file. Output GTF: $gtf_output, Abundances: $abundances_output"
done

