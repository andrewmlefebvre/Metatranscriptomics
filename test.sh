#!/bin/bash

mkdir -p out/trinotate
rm -r -f out/trinotate/*
cp data/mini_sprot.pep out/trinotate/mini_sprot.pep
makeblastdb -in out/trinotate/mini_sprot.pep -dbtype prot
