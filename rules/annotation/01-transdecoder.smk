configfile: "config.yaml" 

rule transdecoder:
    input:
        'flags/kallisto.done', 'flags/rnaquast.done', 'flags/busco.done'
    output:
        'out/transdecoder/longest_orfs.pep'
    shell:
        '''
        (cd out; TransDecoder.LongOrfs -t Trinity.fasta --output_dir transdecoder)
        (cd out; TransDecoder.Predict -t Trinity.fasta --output_dir transdecoder)
        '''





#rule trinotate:
#    #input:
#    #    'flags.transdecoder.done'
#    output:
#        touch('flags/trinotate.done')
#    shell:
#        '''
#        
#        Trinotate Trinotate.sqlite init \
#        --gene_trans_map data/sample_assembly.gene_trans_map \
#        --transcript_fasta data/sample_assembly.fasta \
#        --transdecoder_pep data/sample_assembly.fasta.transdecoder.pep
#        '''             