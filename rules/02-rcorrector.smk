
rule rcorrectorDependencies:
    input:
        #Require fastqc ran correctly
        'flags/fastqc.done'
    output:
        touch('flags/rcorrectorDependencies.done')
    shell:
        '''
        if [ ! -d "snakelib/Rcorrector" ]; then
            (cd snakelib; git clone https://github.com/mourisl/Rcorrector.git)
            (cd snakelib/Rcorrector; make)
        fi
        '''      

rule rcorrector:
    input:
        #Require fastqc ran correctly
        'flags/rcorrectorDependencies.done'
    output:
        touch('flags/rcorrector.done')
    shell:
        '''
        perl snakelib/Rcorrector/run_rcorrector.pl -s data/SRR000676.fastq -od out -t 35
        '''      