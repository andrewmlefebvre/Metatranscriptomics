

rule trimmomatic:
    input:
        "flags/rcorrector.done"
    output:
        'out/outputfile.trim.fq',
        touch('flags/final.done')
    shell:
        #              input                 output                 Trimming options 
        '''            
        trimmomatic SE out/SRR000676Small.cor.fq  out/outputfile.trim.fq TRAILING:3 SLIDINGWINDOW:4:15 MINLEN:36 -phred33
        '''    