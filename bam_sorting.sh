
#!/bin/bash

# Input directory containing BAM files
input_dir="/mnt/storage/labs/insco/Bioinfo_for_all/priyanka/mapped_data/bams"

# Output directory for sorted BAM files
output_dir="/mnt/storage/labs/insco/Bioinfo_for_all/priyanka/mapped_data/sorted_bams"

# Temporary directory
temp_dir="/mnt/storage/labs/insco/Bioinfo_for_all/priyanka/tmp_sort"

# Number of threads
threads=6

# Check if the input directory exists
if [ ! -d "$input_dir" ]; then
    echo "Error: Input directory not found."
    exit 1
fi

# Create the output directory if it doesn't exist
mkdir -p "$output_dir"

# Loop through BAM files in the input directory
for bam_file in "$input_dir"/*.bam; do
    # Extract file name (excluding extension and path)
    base_name=$(basename "$bam_file" .bam)

    # Output sorted BAM file name
    sorted_bam="$output_dir/${base_name}_sorted.bam"

    # Create the temporary directory if it doesn't exist
    mkdir -p "$temp_dir"

    # Run samtools sort
    samtools sort -@ "$threads" -T "$temp_dir" "$bam_file" -o "$sorted_bam"

    # Clean up temporary directory (optional)
    # rm -r "$temp_dir"

    echo "Sorted $bam_file and saved as $sorted_bam"
done
