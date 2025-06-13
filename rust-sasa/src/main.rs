use std::env;

use rust_sasa::{SASALevel, calculate_sasa};

fn main() {
    let args: Vec<String> = env::args().collect();
    let pdb_path = &args[1];

    let (pdb, _errors) = pdbtbx::open(pdb_path).unwrap();
    let result = calculate_sasa(&pdb, None, None, SASALevel::Protein);
    match result {
        Ok(v) => {
            println!("{:?}", v)
        }
        Err(error) => println!("error: {:?}", error),
    }
}
