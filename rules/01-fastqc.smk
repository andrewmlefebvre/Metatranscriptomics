


rule fastqc:
    input:
    output:
        # No actual output from bash
        touch("flags/fastqc.done")
    shell:
        '''
        rm -r out/* 
        fastqc data/SRR000676.fastq.gz -o out
        '''
