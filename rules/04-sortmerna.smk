

rule kraken2Dependencies:
    input:
        'flags/rcorrector.done'
    output:
        touch('kraken2Dependencies')
    shell:


rule kraken2:
    input:
    output:
    shell: