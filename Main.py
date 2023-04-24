import os
import argparse
import json 

def setup():
    parser = argparse.ArgumentParser(
                    prog='MarMMa',
                    description='Metatranscripomic Pipeline')
    
    parser.add_argument('-i', help='Input file', type=str)
    parser.add_argument('-o', help='Output directory', type=str)
    parser.add_argument('-kdb', help='Path to database for kraken2 contaminant removal', type=str)
    parser.add_argument('--run-kraken', help='Indicator to run kraken2 contaminaint removal', action=argparse.BooleanOptionalAction)
    
    args = vars(parser.parse_args())
    
    out = "--config"
    if args['i'] != None:
        try:
            f = open(args['i'])
        except FileNotFoundError:
            print(args['i']+' does not exist')

        iFile = args['i'].split('/')[-1]
        iDir = args['i'].rsplit('/', 1)[0]
        out += " inputFile="+iFile
        out += " inputDir="+iDir 
    else:
        raise Exception("-i Inputfile required")    


    if args['o'] != None:
        try:    
            f = os.path.isdir(args['o'])
        except FileNotFoundError:
            print(args['o']+' does not exist')
        out += " outputDir="+args['o']
    else:
        raise Exception("-o Output directory required")   
   
    if args['kdb'] != None:
        if not os.path.exists(args['kdb']):
            raise FileNotFoundError("Kraken database path is invalid")
        kdb = args['kdb']
        out += " kdb="+kdb

    if args['run_kraken'] != None:
        k2 = args['run_kraken']
        out += " runKraken2="+str(k2)   

    if args['run_kraken'] != None and args['kdb'] == None:
        raise FileNotFoundError("Kraken database path is missing") 

    return out    

if __name__ == '__main__':

    out = setup()

    # Delete all previous outputs
    os.system("snakemake  --snakefile rules/Snakefile --unlock --delete-all-output --cores 1")
    os.system("sudo rm -f -r out/* ")
    os.system("sudo touch out/.gitkeep")
    os.system("rm -f flags/* ")

    # Run from start
    print(out)
    os.system("snakemake  --snakefile rules/Snakefile --cores 1 flags/final.done "+out)   