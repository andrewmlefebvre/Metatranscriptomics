
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
    shell:
        '''
	./snakelib/kraken2/kraken2 --db {params.kdb} --report out/kraken2_report.report --classified-out out/kraken2.classified --unclassified-out {output.outputFile} --use-names {input.inputfile} > out/kraken2_report.out
	'''
