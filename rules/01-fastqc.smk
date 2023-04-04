


rule fastqc:
    input:
        'data/SRR000676Small.fastq'
    output:
        'out/SRR000676Small_fastqc.html',
        touch('flags/fastqc.done')
    shell:
        '''
        fastqc data/SRR000676Small.fastq -o out
        '''
