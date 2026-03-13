#!/bin/bash
input_bam=$1
output_dir=$2

base_name=$(basename "$input_bam" .bam)

mkdir -p "$output_dir"

# Initialize conda and set up the bam2bed environment
echo "Setting up Conda environment with bedtools..."
source $(dirname $(dirname $(which mamba)))/etc/profile.d/conda.sh
mamba create -n bam2bed -y -c bioconda -c conda-forge bedtools > /dev/null 2>&1
conda activate bam2bed
echo "Setting up Conda succesfuly"

echo "Converting BAM to BED format..."
bedtools bamtobed -i "$input_bam" > "$output_dir/${base_name}.bed"
echo "BED created"

echo "Filtering for Chromosome 1..."
grep -P "^Chr1\t" "$output_dir/${base_name}.bed" > "$output_dir/${base_name}_chr1.bed"

echo "saving to text file..."
wc -l "$output_dir/${base_name}_chr1.bed" > "$output_dir/bam2bed_number_of_rows.txt"

echo "Done! I am NOT a MONKEY"
echo "Tommy Leijtens"
