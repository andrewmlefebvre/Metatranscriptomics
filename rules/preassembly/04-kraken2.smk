

rule kraken2Dependencies:
    input:
        'flags/fastqc.done'
    output:
        touch('flags/kraken2Dependencies.done')
    shell:
        '''
            if [ ! -d "snakelib/Kraken2" ]; then
                (cd snakelib; git clone https://github.com/DerrickWood/kraken2.git)
                (cd snakelib/kraken2; bash install_kraken2.sh .)
            fi    
        '''

rule kraken2:
    input:
        'flags/kraken2Dependencies.done',
        'out/outputfile.trim.fq'    
    output:
        touch('flags/final.done')       
    shell:
        
