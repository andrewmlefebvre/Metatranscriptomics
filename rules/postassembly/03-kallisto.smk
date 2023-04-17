configfile: "config.yaml" 

rule kallistoIndex:
    input:
        'out/Trinity.fasta'
    output:
        'out/Trinity.index'
    shell:
        '''
        kallisto index  out/Trinity.fasta -i out/Trinity.index
        '''        

rule kallisto:
    input:
        'out/Trinity.index',
        ('out/'+config['inputFile'].split('.')[0]+'.kraken.fq')
    output:
        touch('flags/kallisto.done')
    params:
        meanLength = config['meanFragmentLength'],
        lengthSD = config['fragmentSD'],
        inputFq = ('out/'+config['inputFile'].split('.')[0]+'.kraken.fq')
    shell:
        '''
        kallisto quant -i out/Trinity.index -o out/kallisto --single -l {params.meanLength} -s {params.lengthSD} {params.inputFq}
        '''