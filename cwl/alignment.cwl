#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: Workflow
inputs:
  genome: File
  fastq: File
  outname: string

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
    out: [reads_out]

  samtools-sort:
    run: samtools-sort.cwl
    in:
      outputBam: outname
      inputSam: bwamap/reads_out
    out: [out_bam]

  samtools-index:
    run: samtools-index.cwl
    in:
      inputBam: samtools-sort/out_bam
    out: [out_bai]

outputs:
  out_bam:
    type: File
    outputSource: samtools-sort/out_bam
