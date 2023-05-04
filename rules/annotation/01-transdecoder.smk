configfile: "config.yaml" 

rule transdecoder:
    input:
        'flags/kallisto.done', 'flags/rnaquast.done'
    output:
        'out/transdecoder/longest_orfs.pep'
    shell:
        '''
        (cd out; TransDecoder.LongOrfs -t Trinity.fasta --output_dir transdecoder)
        (cd out; TransDecoder.Predict -t Trinity.fasta --output_dir transdecoder)
        '''

