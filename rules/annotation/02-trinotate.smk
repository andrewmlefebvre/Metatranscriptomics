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
        'out/transdecoder/longest_orfs.pep',
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
        'out/transdecoder/longest_orfs.pep',
        'out/trinotate/blastp.outfmt6'
    output:
        'out/trinotate/TrinotatePFAM.out'
    shell:
        '''
            mkdir -p out/hmmscan
            (cd out/hmmscan; wget https://data.broadinstitute.org/Trinity/Trinotate_v3_RESOURCES_sample_data_only/Pfam-A.hmm)
            hmmpress out/hmmscan/Pfam-A.hmm
            hmmscan --cpu 2 \
            --domtblout out/trinotate/TrinotatePFAM.out \
            out/hmmscan/Pfam-A.hmm out/transdecoder/longest_orfs.pep > out/trinotate/pfam.log
        '''        


rule signalp:
    input:
        'out/transdecoder/longest_orfs.pep',
        'out/Trinity.fasta'
    output:
        'out/trinotate/signalp.out'
    shell:
        '''
            (cd data/util/signalp-5.0b/bin; ./signalp -fasta ../../../../out/Trinity.fasta -stdout > ../../../../out/trinotate/signalp.out)
        '''    

#TODO? Does not seem to work with any attempted perl versions
#rule tmhmm:

rule trinotate:
    input:
        'out/transdecoder/longest_orfs.pep',
        'out/Trinity.fasta',
        'out/Trinity.fasta.gene_trans_map',
        'out/trinotate/blastp.outfmt6',
        'out/trinotate/blastx.outfmt6',
        'out/trinotate/signalp.out',
        'out/trinotate/TrinotatePFAM.out'
    output:
        'out/trinotate/trinotate_annotation_report.xls'
    shell:
        '''
            (cd out/trinotate; wget https://data.broadinstitute.org/Trinity/Trinotate_v3_RESOURCES_sample_data_only/Trinotate.sample_data_only_boilerplate.sqlite.gz;)
            (cd out/trinotate; gzip -d Trinotate.sample_data_only_boilerplate.sqlite.gz;)
            (cd out/trinotate; mv Trinotate.sample_data_only_boilerplate.sqlite Trinotate.sqlite)

            Trinotate out/trinotate/Trinotate.sqlite init \
            --gene_trans_map out/Trinity.fasta.gene_trans_map \
            --transcript_fasta out/Trinity.fasta \
            --transdecoder_pep out/transdecoder/longest_orfs.pep

            Trinotate out/trinotate/Trinotate.sqlite LOAD_swissprot_blastp out/trinotate/blastp.outfmt6
            Trinotate out/trinotate/Trinotate.sqlite LOAD_swissprot_blastx out/trinotate/blastx.outfmt6
            Trinotate out/trinotate/Trinotate.sqlite LOAD_pfam out/trinotate/TrinotatePFAM.out
            #Trinotate out/trinotate/Trinotate.sqlite LOAD_tmhmm out/trinotate/tmhmm.out
            Trinotate out/trinotate/Trinotate.sqlite LOAD_signalp out/trinotate/signalp.out

            Trinotate out/trinotate/Trinotate.sqlite report > out/trinotate/trinotate_annotation_report.xls
        '''
