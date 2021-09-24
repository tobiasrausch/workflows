#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
baseCommand: [ bwa, mem ]
requirements:
  InitialWorkDirRequirement:
    listing:
      - $(inputs.genomeFile)

inputs:
  genomeFile:
    type: File
    inputBinding:
      position: 1
    secondaryFiles:
      - .amb
      - .ann
      - .bwt
      - .pac
      - .sa
  fastqFile:
    type: File
    inputBinding:
      position: 2

stdout: $(inputs.fastqFile.basename).sam

outputs:
  reads_out:
    type: stdout

