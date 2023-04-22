configfile: "config.yaml" 


rule makeblastdb:
    input:
        'out/Trinity.fasta',
        'data/mini_sprot.pep'
    output:
        'out/trinotate/mini_sprot.pep',
        'out/trinotate/mini_sprot.pep.pdb'   
    shell:
        '''
            mkdir -p out/trinotate
            rm -r -f out/trinotate/*
            cp data/mini_sprot.pep out/trinotate/mini_sprot.pep
            makeblastdb -in out/trinotate/mini_sprot.pep -dbtype prot
        '''


rule blastx:
    input:
        'out/Trinity.fasta',
        'out/trinotate/mini_sprot.pep'
    output:
        'out/trinotate/blastx.outfmt6'
    shell:
        '''
            blastx -query out/Trinity.fasta \
            -db out/trinotate/mini_sprot.pep \
            -num_threads 8 \
            -max_target_seqs 1 \
            -outfmt 6 > out/trinotate/blastx.outfmt6
        '''    

rule blastp:
    input:
        'out/trinotate/blastx.outfmt6',
        #'out/transdecoder/longest_orfs.pep',
        'out/Trinity.fasta'
    output:
        'out/trinotate/blastp.outfmt6'
    shell:
        '''
            blastp -query out/transdecoder/longest_orfs.pep \
            -db out/trinotate/mini_sprot.pep \
            -num_threads 8 \
            -max_target_seqs 1 \
            -outfmt 6 > out/trinotate/blastp.outfmt6
        '''            



rule hmmscan:
    input:
        #'out/transdecoder/longest_orfs.pep',
        'out/trinotate/blastp.outfmt6'
    output:
        touch('flags/test.done')
    shell:
        '''
            mkdir -p out/hmmscan
            (cd out/hmmscan; wget https://data.broadinstitute.org/Trinity/Trinotate_v3_RESOURCES_sample_data_only/Pfam-A.hmm)
            hmpress out/hmmscan/Pfam-A.hmm
            hmmscan --cpu 2 \
            --domtblout out/trinotate/TrinotatePFAM.out \
            out/hmmscan/Pfam-A.hmm out/transdecoder/longest_orfs.pep > out/trinotate/pfam.log
        '''        

