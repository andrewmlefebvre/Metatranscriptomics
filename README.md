# Metatranscriptomics

Metatranscriptomics is an exciting new area of inquiry with important applications in medical and environmental science fields, among others. By analyzing the RNA of a biological community--perhaps that of an organism's microbiome or free-living marine microbes--we can determine which genes are actually being expressed by the community, and, therefore, which functions the organisms in that community are actively carrying out.

Conda Dependencies: environment.yml

Pip Dependencies: requirements.txt

# Usage

The MarMMA pipline can be installed using "docker pull andrewmlefebvre/marmma"

It can then be run with "docker run -it andrewmlefebvre/marmma {arguments}"

## Required
-i : Input file path

## Optional
-kdb : Path to kraken2 database

--run-kraken : Execute the kraken2 contamination removal

** By default kraken2 is skipped

Use -h so see full usage