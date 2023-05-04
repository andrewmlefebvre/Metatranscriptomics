configfile: "config.yaml" 

import os

rule trinityDependencies:
    input:
        'flags/fastqc.done'

    output:
        touch('flags/trinityDependencies.done')
    shell:
        '''
            if [ ! -d "snakelib/trinity" ]; then
                (cd snakelib; wget https://github.com/trinityrnaseq/trinityrnaseq/releases/download/Trinity-v2.14.0/trinityrnaseq-v2.14.0.FULL.tar.gz; tar -xvzf trinityrnaseq-v2.14.0.FULL.tar.gz; mv trinityrnaseq-v2.14.0 trinity; rm trinityrnaseq-v2.14.0.FULL.tar.gz)
                (cd trinity; make)
                (cd ..)
            fi
        '''

rule trinity:
    input:
        'flags/trinityDependencies.done',
        inputFile = ('out/'+config['inputFile'].split('.')[0]+'.kraken.fq')
    output:
        'out/Trinity.fasta',
        'out/Trinity.fasta.gene_trans_map'
    params:
        mem = config['trinityMaxMem']
    shell:
        '''
       # docker pull trinityrnaseq/trinityrnaseq
        
        ./snakelib/trinity/Trinity --seqType fq --single `pwd`/{input.inputFile} --output `pwd`/out/trinityout --max_memory {params.mem} --full_cleanup --CPU 19 
        cp out/trinityout.Trinity.fasta out/Trinity.fasta
        cp out/trinityout.Trinity.fasta.gene_trans_map out/Trinity.fasta.gene_trans_map
        rm -f out/trinityout.Trinity.fasta.gene_trans_map
        rm -f out/trinityout.Trinity.fasta
        '''
