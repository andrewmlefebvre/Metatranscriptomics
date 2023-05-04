configfile: "config.yaml" 

rule fastqc:
    input:
        inputFile = config['inputDir'] + '/' + config['inputFile']
    output:
        touch('flags/fastqc.done')
    params:    
        outputDir = config['outputDir']
    shell:
        '''
        fastqc {input.inputFile} -o {params.outputDir} -t 39
        '''
