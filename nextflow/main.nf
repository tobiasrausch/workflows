
params.genome = "$baseDir/../data/genome.fa"
params.reads = "$baseDir/../data/samples/{A,B}.fastq.gz"


Channel.fromPath(params.reads).set{infiles}

process build_index {
   input:
   path genome from params.genome

   output:
   path 'genome.fa.*' into genomeidx

   script:
   """
   bwa index ${genome}
   """
}

process bwa_map {
   input:
   path infile from infiles
   path genome from params.genome
   path index from genomeidx

   output:
   file "${infile.getBaseName()}.bam" into out_bams

   script:
   outname = infile.getBaseName()
   outname += ".bam"
   """
   bwa mem $genome $infile | samtools sort -o $outname
   """
}
