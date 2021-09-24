#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
baseCommand: [ samtools , sort ]
inputs:
  outputBam:
    type: string
    inputBinding:
      prefix: "-o"
  inputSam:
    type: File
    inputBinding:
      position: 2
outputs:
  out_bam:
    type: File
    outputBinding:
      glob: "$(inputs.outputBam)"

