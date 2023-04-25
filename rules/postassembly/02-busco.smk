configfile: "config.yaml" 

rule buscoDependencies:
    output:
        touch('flags/buscoDependencies.done')
    shell:
        '''
        if [ ! -d "snakelib/busco" ]; then
            (cd snakelib; git clone https://gitlab.com/ezlab/busco.git)
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
        docker pull ezlabgva/busco:v5.4.4_cv1
        docker run -u $(id -u) -v $(pwd):/busco_wd ezlabgva/busco:v5.4.4_cv1 busco -f -i out/Trinity.fasta -o out/busco -m transcriptome
        '''              
