configfile: "config.yaml" 


rule bellerophonDependencies:
    input:
        #Require fastqc ran correctly
        'flags/fastqc.done'
    output:
        touch('flags/bellerophonDependencies.done')
    shell:
        '''
        if [ ! -d "snakelib/Bellerophon" ]; then
            (cd snakelib; git clone https://github.com/JesseKerkvliet/Bellerophon.git)
        fi
        '''    

rule bellerophon:
    input:
        'flags/bellerophonDependencies.done',
        ('out/'+config['inputFile'].split('.')[0]+'.trim.fq') 
    output:
        touch('flags/final.done')   
    shell:    
        '''    
        echo todo
        ''' 