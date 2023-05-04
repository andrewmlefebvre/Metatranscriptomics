configfile: "config.yaml" 

rule trimmomatic:
    input:
        inputFile = ('out/'+config['inputFile'].split('.')[0]+'.cor.fq')
    output:
        outputFile = ('out/'+config['inputFile'].split('.')[0]+'.trim.fq')
    params:
        trailing = (config['Trailing']), 
        window = (str(config['SlidingWindowA']) + ':' + str(config['SlidingWindowB'])), 
        minLen = (config['MinLen']), 
        phred = (config['Phred'])

    shell:
        #              input              output             Trimming options 
        '''         
        trimmomatic SE {input.inputFile} {output.outputFile} TRAILING:{params.trailing} SLIDINGWINDOW:{params.window} MINLEN:{params.minLen} -{params.phred} -threads 39   
        '''    
