import os

if __name__ == '__main__':
    # Delete all previous outputs
    os.system("snakemake  --snakefile rules/Snakefile --delete-all-output --cores 1")
    # Run from start
    os.system("snakemake  --snakefile rules/Snakefile --cores 1")
