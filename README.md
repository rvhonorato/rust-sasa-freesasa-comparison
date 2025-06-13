# rust-sasa-freesasa-comparison

This repository contains scripts to analyse the correlation between `rust-sasa` and `freesasa`

## Usage

- [Install freesasa](https://freesasa.github.io)
- Compile a minimal cli from `rust-sas

  ```bash
  cd rust-sas
  crgo build --release
  cp target/release/rustsasa-freesasa ../rust-sasa-bin
  cd ..
  ``

  ```

- Download the PDBs: `bash scripts/download-pdbs.sh`

- Run both `freesasa` and `rust-sasa`: `bash scripts/comparison.sh`

- Calculate basic statistics and plot a linear regression: `Rscript scripts/analyse.R`

## Results

- FreeSASA v2.1.2
- RustSASA v0.2
- Dataset 1 from 10.12688/f1000research.7931.1

<Plot goes here>

