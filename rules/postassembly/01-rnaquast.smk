configfile: "config.yaml" 


rule rnaquastDependencies:
    input:
        #Require fastqc ran correctly
        'flags/fastqc.done'
    output:
        touch('flags/rnaquastDependencies.done')
    shell:
        '''
        if [ ! -d "snakelib/rnaquast" ]; then
            (cd snakelib; git clone https://github.com/ablab/rnaquast.git)
        fi
        '''    
   
rule rnaquast:
    input:
        'flags/rnaquastDependencies.done',
        'out/Trinity.fasta',
        'out/Trinity.fasta.gene_trans_map'
    output:
        touch('flags/rnaquast.done')   
    shell:    
        '''    
        python3 snakelib/rnaquast/rnaQUAST.py -c out/Trinity.fasta -o out/rnaquast
        ''' 