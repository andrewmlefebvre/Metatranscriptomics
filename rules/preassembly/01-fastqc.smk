configfile: "config.yaml" 

rule fastqc:
    input:
        inputFile = config['inputDir'] + '/' + config['inputFile']
    output:
        touch('flags/fastqc.done')
    shell:
        '''
        fastqc {input.inputFile} -o out
        '''
