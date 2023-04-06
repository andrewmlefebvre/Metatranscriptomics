configfile: "config.yaml" 


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
        'flags/rcorrectorDependencies.done',
        inputFile = config['inputDir'] + '/' + config['inputFile']
    output:
        ('out/'+config['inputFile'].split('.')[0]+'.cor.fq')
    shell:
        '''
        perl snakelib/Rcorrector/run_rcorrector.pl -s {input.inputFile} -od out -t 35
        '''      