
#!/bin/bash
source activate custom


# Set the input and output directories
input_dir="/mnt/storage/labs/insco/test_HG/CLOVER-1_trimmed_mapped"
output_dir="/mnt/storage/labs/insco/test_HG/CLOVER-1_trimmed_mapped"

# Set the path to the chromosome sizes file
chrom_sizes_file="/mnt/storage/labs/insco/pipeline/genomes/human_genome/chrNameLength.txt"

# Create the output directory if it doesn't exist
mkdir -p "$output_dir"

# Loop through all bedgraph files in the input directory
for bedgraph_file in "$input_dir"/*out.bg; do
    # Get the base name of the file (excluding path and extension)
    base_name=$(basename "$bedgraph_file" ".bg")

    # Set the temporary sorted bedgraph file name
    sorted_bedgraph_file="$output_dir/${base_name}_sorted.bg"

    # Run sort with the recommended options
    LC_COLLATE=C sort -k1,1 -k2,2n "$bedgraph_file" > "$sorted_bedgraph_file"

    # Set the output bigwig file name
    bigwig_file="$output_dir/${base_name}.bw"

    # Run bedGraphToBigWig
    bedGraphToBigWig "$sorted_bedgraph_file" "$chrom_sizes_file" "$bigwig_file"

    # Print the base name
    echo "File: $bedgraph_file, Base Name: $base_name"
done

