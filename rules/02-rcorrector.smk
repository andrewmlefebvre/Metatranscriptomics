
rule rcorrectorDependencies:
    input:
        #Require fastqc ran correctly
        'flags/fastqc.done'
    output:
        touch('flags/rcorrectorDependencies.done')
    shell:
        '''
        if [ ! -d "lib/Rcorrector" ]; then
            (cd lib; git clone https://github.com/mourisl/Rcorrector.git)
            (cd lib/Rcorrector; make)
        fi
        '''      

rule rcorrector:
    input:
        #Require fastqc ran correctly
        'flags/rcorrectorDependencies.done'
    output:
        touch('out/test.txt')
    shell:
        '''
        perl lib/Rcorrector/run_rcorrector.pl -s data/SRR000676.fastq -od out -t 35
        '''      