#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: Workflow
inputs:
  genome: File
  fastq: File
  outname: string
outputs: []

steps:
  bwaindex:
    run: bwa-index.cwl
    in:
      genomeFile: genome
    out:
      - index_file

  bwamap:
    run: bwa-map.cwl
    in:
      genomeFile: bwaindex/index_file
      fastqFile: fastq
    out:
      - reads_out

  samtools-sort:
    run: samtools-sort.cwl
    in:
      outputBam: outname
      inputSam: bwamap/reads_out
    out: []
