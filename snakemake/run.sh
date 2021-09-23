#!/bin/bash

SCRIPT=$(readlink -f "$0")
BASEDIR=$(dirname "$SCRIPT")
export PATH=${BASEDIR}/../conda/bin:${PATH}

source activate workflows

# Dry-run
snakemake -np

# Execute workflow
snakemake --cores 1

# Plot DAG of jobs
snakemake --dag | dot -Tsvg > plots/job_exec.svg

# HTML report
snakemake --report plots/report.html
