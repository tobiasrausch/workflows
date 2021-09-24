#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
baseCommand: [ samtools , index ]
requirements:
  InitialWorkDirRequirement:
    listing:
      - $(inputs.inputBam)

inputs:
  inputBam:
    type: File
    inputBinding:
      position: 1
outputs:
  out_bai:
    type: File
    outputBinding:
      glob: "$(inputs.inputBam.basename).bai"
