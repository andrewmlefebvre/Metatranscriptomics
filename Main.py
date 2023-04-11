import os


if __name__ == '__main__':

    # Delete all previous outputs
    os.system("snakemake  --snakefile rules/Snakefile --unlock --delete-all-output --cores 1")
    os.system("sudo rm -f -r out/* ")
    os.system("rm -f flags/* ")
    # Run from start
    os.system("snakemake  --snakefile rules/Snakefile --cores 1 flags/final.done")
