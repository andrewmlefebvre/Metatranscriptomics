


rule fastqc:
    input:
        'data/SRR000676.fastq.gz'
    output:
        'out/SRR000676_fastqc.html',
        touch('flags/fastqc.done')
    shell:
        '''
        fastqc data/SRR000676.fastq.gz -o out
        '''
