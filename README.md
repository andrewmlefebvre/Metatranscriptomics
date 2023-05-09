# Metatranscriptomics

Metatranscriptomics is an exciting new area of inquiry with important applications in medical and environmental science fields, among others. By analyzing the RNA of a biological community--perhaps that of an organism's microbiome or free-living marine microbes--we can determine which genes are actually being expressed by the community, and, therefore, which functions the organisms in that community are actively carrying out.

Conda Dependencies: environment.yml

Pip Dependencies: requirements.txt

# Usage

The MarMMA pipline can be installed using the conda and pip dependecy lists. While in the root directory execute the following

apt-get install -y make zlib1g-dev gcc g++ python3-pip

conda env create -f environment.yml --force

pip install -r requirements.txt --no-cache-dir

## Required
-i : Input file path

## Optional
-kdb : Path to kraken2 database

--run-kraken : Execute the kraken2 contamination removal

** By default kraken2 is skipped

Use -h so see full usage
