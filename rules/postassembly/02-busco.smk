configfile: "config.yaml" 

rule buscoDependencies:
    output:
        touch('flags/buscoDependencies.done')
    shell:
        '''
        if [ ! -d "snakelib/busco" ]; then
            (cd snakelib; git clone https://gitlab.com/ezlab/busco.git)
            (cd snakelib/busco; python3 setup.py install --user)
        fi
        '''      

rule busco:
    input:
        'out/Trinity.fasta',
        ('out/'+config['inputFile'].split('.')[0]+'.kraken.fq'),
        'flags/buscoDependencies.done'
    output:
        touch('flags/busco.done') 
    shell:
        '''
            busco -f -i out/Trinity.fasta -o out/busco -m transcriptome        
        '''              
