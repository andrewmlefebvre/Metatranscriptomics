

rule trimmomatic:
    input:
        "out/rcorrector.done"
    output:
        touch('out/test.txt')
    shell:
        #              input                 output                 Trimming options 
        '''            
        trimmomatic SE out/SRR000676.cor.fq  out/outputfile.trim.fq TRAILING:3 SLIDINGWINDOW:4:15 MINLEN:36 -phred33
        '''    