configfile: "config.yaml" 

rule trinity:
    input:
        inputFile = ('out/'+config['inputFile'].split('.')[0]+'.kraken.fq')
    output:
        'out/Trinity.fasta',
        'out/Trinity.fasta.gene_trans_map'
    params:
        mem = config['trinityMaxMem']
    shell:
        '''
        Trinity --seqType fq --single `pwd`/{input.inputFile} --output `pwd`/out/trinityout --max_memory {params.mem} --full_cleanup --CPU 12
        cp out/trinityout.Trinity.fasta out/Trinity.fasta
        cp out/trinityout.Trinity.fasta.gene_trans_map out/Trinity.fasta.gene_trans_map
        rm -f out/trinityout.Trinity.fasta.gene_trans_map
        rm -f out/trinityout.Trinity.fasta
        '''