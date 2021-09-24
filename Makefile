SHELL := /bin/bash

# Targets
TARGETS = .conda .mamba .install .test
PBASE=$(shell pwd)

all:   	$(TARGETS)

.conda:
	wget 'https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh' && bash Miniconda3-latest-Linux-x86_64.sh -b -p ${PBASE}/conda && rm -f Miniconda3-latest-Linux-x86_64.sh && touch .conda

.mamba: .conda
	export PATH=${PBASE}/conda/bin:${PATH} && conda install -y -n base -c conda-forge mamba && touch .mamba

.install: .conda .mamba
	export PATH=${PBASE}/conda/bin:${PATH} && source activate base && mamba create -y -c conda-forge -c bioconda -n workflows nextflow snakemake networkx matplotlib graphviz bcftools samtools bwa pysam && touch .install

.test: .conda .mamba .install
	export PATH=${PBASE}/conda/bin:${PATH} && source activate workflows && snakemake --version && nextflow -v && touch .test

clean:
	rm -rf snakemake/calls/ snakemake/mapped_reads/ snakemake/plots/ data/genome.fa.* nextflow/work/ nextflow/.nextflow* snakemake/.snakemake* nextflow/calls/

distclean: clean
	rm -rf $(TARGETS) $(TARGETS:=.o) conda/
