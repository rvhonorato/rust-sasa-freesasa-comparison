# RustSASA vs. FreeSASA

This repository contains scripts to analyse the correlation between RustSASA and FreeSASA.

## Usage

> You will need Rust, R and the basic tools to compile freesasa

- Clone this repository `git clone https://github.com/rvhonorato/rustsasa-freesasa-comparison`
- [Install freesasa](https://freesasa.github.io)
- Compile a minimal cli for `rust-sasa`

  ```bash
  cd rust-sasa
  crgo build --release
  cp target/release/rustsasa-freesasa ../rust-sasa-bin
  cd ..
  ```

- Download the PDBs: `bash scripts/download-pdbs.sh`

- Run both `freesasa` and `rust-sasa`: `bash scripts/comparison.sh`

- Calculate basic statistics and plot a linear regression: `Rscript scripts/analyse.R`

## Results

- FreeSASA v2.1.2
- RustSASA v0.2
- [Dataset 1 from 10.12688/f1000research.7931.1](https://pubmed.ncbi.nlm.nih.gov/26973785/)

![image](https://raw.githubusercontent.com/rvhonorato/rustsasa-freesasa-comparison/refs/heads/main/sasa_correlation.png)
