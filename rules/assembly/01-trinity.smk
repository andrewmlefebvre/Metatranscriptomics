configfile: "config.yaml" 

rule trinity:
    input:
        inputFile = ('out/'+config['inputFile'].split('.')[0]+'.trim.fq')
    output:
        'out/Trinity.fasta',
        'out/Trinity.fasta.gene_trans_map'
    params:
        mem = config['trinityMaxMem']
    shell:
        '''
        docker pull trinityrnaseq/trinityrnaseq
        docker run --rm -v`pwd`:`pwd` trinityrnaseq/trinityrnaseq Trinity --seqType fq --single `pwd`/{input.inputFile} --output `pwd`/out/trinityout --max_memory {params.mem} --full_cleanup --CPU 4
        cp out/trinityout.Trinity.fasta out/Trinity.fasta
        cp out/trinityout.Trinity.fasta.gene_trans_map out/Trinity.fasta.gene_trans_map
        rm -f out/trinityout.Trinity.fasta.gene_trans_map
        rm -f out/trinityout.Trinity.fasta
        '''