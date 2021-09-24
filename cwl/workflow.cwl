#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: Workflow

inputs:
  genome: File
  fastq: File[]
  outname: string[]

requirements:
  SubworkflowFeatureRequirement: {}
  ScatterFeatureRequirement: {}

steps:
  alignment:
    run: alignment.cwl
    scatter: [fastq, outname]
    scatterMethod: dotproduct
    in:
      genome: genome
      fastq: fastq
      outname: outname
    out: [out_bam]

outputs:
  out_bam:
    type:
      type: array
      items: File
    outputSource: alignment/out_bam
