configfile: "config.yaml" 

import os

rule kraken2Dependencies:
    input:
        'flags/fastqc.done'

    output:
        touch('flags/kraken2Dependencies.done')
    shell:
        '''
            if [ ! -d "snakelib/kraken2" ]; then
                (cd snakelib; git clone https://github.com/djperrone/kraken2.git)
                (cd snakelib/kraken2; bash install_kraken2.sh .)
            fi    
        '''

rule kraken2:
    input:
        'flags/kraken2Dependencies.done',
	    inputfile = ('out/'+config['inputFile'].split('.')[0]+'.trim.fq')
    output:
        touch('flags/kraken.done'),
	    outputFile = ('out/'+config['inputFile'].split('.')[0]+'.kraken.fq')       
    params:
        kdb = (config['kdb']) 
    run:
        if config['runKraken2']:
            os.system("./snakelib/kraken2/kraken2 --db "+config['kdb']+" --report out/kraken2_report.report --classified-out out/kraken2.classified --unclassified-out "+('out/'+config['inputFile'].split('.')[0]+'.kraken.fq') +"  "+('out/'+config['inputFile'].split('.')[0]+'.trim.fq')+" > out/kraken2_report.out")
        else:
            print("---Skipping kraken2---")
            os.system("cp "+('out/'+config['inputFile'].split('.')[0]+'.trim.fq')+" "+('out/'+config['inputFile'].split('.')[0]+'.kraken.fq') )
