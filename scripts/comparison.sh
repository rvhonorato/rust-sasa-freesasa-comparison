#!/bin/bash

# Input file containing PDB codes
INPUT_FILE="freesasa-dataset.txt"
OUTPUT_FILE="sasa_comparison.csv"

# Check if input file exists
if [ ! -f "$INPUT_FILE" ]; then
  echo "Error: File $INPUT_FILE not found!"
  exit 1
fi

# Create CSV header
echo "pdbid,rust-sasa,freesasa" >"$OUTPUT_FILE"

# Read each PDB code from the file
while IFS= read -r pdb_code; do
  # Skip empty lines
  if [ -z "$pdb_code" ]; then
    continue
  fi

  PDB_FILE="pdb_files/${pdb_code}.pdb"

  # Check if PDB file exists
  if [ ! -f "$PDB_FILE" ]; then
    echo "Warning: $PDB_FILE not found, skipping..."
    continue
  fi

  echo "Processing $pdb_code..."

  # Run rust-sasa and extract the global_total value
  rust_output=$(./rust-sasa-bin "$PDB_FILE" 2>/dev/null)
  rust_value=$(echo "$rust_output" | grep -o 'global_total: [0-9.]*' | cut -d' ' -f2)

  # Run freesasa and extract the Total value
  freesasa_output=$(freesasa "$PDB_FILE" 2>/dev/null)
  freesasa_value=$(echo "$freesasa_output" | grep "Total" | grep -o '[0-9.]*')

  # Check if we got valid values
  if [ -n "$rust_value" ] && [ -n "$freesasa_value" ]; then
    echo "$pdb_code,$rust_value,$freesasa_value" >>"$OUTPUT_FILE"
    echo "  rust-sasa: $rust_value, freesasa: $freesasa_value"
  else
    echo "  Error: Could not extract values for $pdb_code"
    echo "$pdb_code,ERROR,ERROR" >>"$OUTPUT_FILE"
  fi

done <"$INPUT_FILE"

echo "Results saved to $OUTPUT_FILE"
echo "Sample of results:"
head -10 "$OUTPUT_FILE"
