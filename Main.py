import os

if __name__ == '__main__':
    # Delete all previous outputs
    os.system("snakemake  --snakefile rules/Snakefile --delete-all-output")
    # Run from start
    os.system("snakemake  --snakefile rules/Snakefile")