configfile: "config.yaml" 


rule busco:
    input:
        'out/Trinity.fasta',
        ('out/'+config['inputFile'].split('.')[0]+'.trim.fq')   
    output:
        touch('flags/busco.done') 
    shell:
        '''
        docker pull ezlabgva/busco:v5.4.4_cv1
        docker run -u $(id -u) -v $(pwd):/busco_wd ezlabgva/busco:v5.4.4_cv1 busco -f -i out/Trinity.fasta -o out/busco -m genome
        '''              
