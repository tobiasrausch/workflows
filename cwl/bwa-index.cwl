#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
baseCommand: [ bwa , index ]
requirements:
  InitialWorkDirRequirement:
    listing:
      - $(inputs.genomeFile)

inputs:
  genomeFile:
    type: File
    inputBinding:
      position: 1
outputs:
  index_file:
    type: File
    secondaryFiles:
      - .amb
      - .ann
      - .bwt
      - .pac
      - .sa
    outputBinding:
      glob: "$(inputs.genomeFile.basename)"
