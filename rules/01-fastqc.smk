


rule fastqc:
    input:
    output:
        # No actual output from bash
        touch("flags/fastqc.done")
    shell:
        '''
        echo Here
        rm -r out/* 
        fastqc data/SRR000676.fastq.gz -o out
        '''
