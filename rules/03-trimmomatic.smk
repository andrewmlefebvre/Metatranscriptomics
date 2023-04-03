

rule trimmomatic:
    input:
        "flags/rcorrector.done"
    output:
        'out/outputfile.trim.fq'
    shell:
        #              input                 output                 Trimming options 
        '''            
        trimmomatic SE out/SRR000676.cor.fq  out/outputfile.trim.fq TRAILING:3 SLIDINGWINDOW:4:15 MINLEN:36 -phred33
        '''    