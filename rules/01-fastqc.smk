


rule fastqc:
    output:
        # No actual output from bash
        touch('flags/fastqc.done')
    shell:
        '''
        rm -f out/* 
        fastqc data/SRR000676.fastq.gz -o out
        '''
