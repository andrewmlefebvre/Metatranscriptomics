configfile: "config.yaml" 

rule trinotateDependencies:
    output:
        touch('flags/trinotateDependencies.done')
    shell:
        '''
        (cd out; wget https://data.broadinstitute.org/Trinity/Trinotate_v3_RESOURCES/uniprot_sprot.pep.gz)
        (cd out; wget https://data.broadinstitute.org/Trinity/Trinotate_v3_RESOURCES/Pfam-A.hmm.gz)
        (cd out; gunzip uniprot_sprot.pep.gz)
        (cd out; gunzip Pfam-A.hmm.gz)
        (cd out; makeblastdb -in uniprot_sprot.pep -dbtype prot)
        (cd out; hmmpress Pfam-A.hmm)
        '''

rule trinotateSearches:
    input: 
        'out/longest_orfs.pep',
        'flags/kallisto.done', 'flags/rnaquast.done', 'flags/busco.done',
        'out/Trinity.fasta',
        'out/Trinity.fasta.gene_trans_map',
        'flags/trinotateDependencies.done'
    output:
    shell:
        '''
        '''    

rule trinotate:
    input:
        'out/longest_orfs.pep',
        'flags/kallisto.done', 'flags/rnaquast.done', 'flags/busco.done',
        'out/Trinity.fasta',
        'out/Trinity.fasta.gene_trans_map',
        'flags/trinotateDependencies.done'
    output:
        touch('flags/trinotate.done')
    shell:
        '''

        '''