#!/bin/bash

python Main.py -i data/Time2_Bag1_mRNA.fastq -o out
cp -r out final_out/t2b1
rm -r out/*

python Main.py -i data/Time2_Bag6_mRNA.fastq -o out
cp -r out final_out/t2b6
rm -r out/*

python Main.py -i data/Time1_Bag1_mRNA.fastq -o out 
cp -r out final_out/t1b1
rm -r out/*

python Main.py -i data/Time1_Bag6_mRNA.fastq -o out 
cp -r out final_out/t1b6
rm -r out/*
