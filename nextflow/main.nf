
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
   file "${infile.getBaseName()}.bam" into bam_files
   file "${infile.getBaseName()}.bam.bai" into bai_files

   script:
   outname = infile.getBaseName()
   outname += ".bam"
   """
   bwa mem $genome $infile | samtools sort -o $outname
   samtools index $outname
   """
}

process bcftools_call {
   publishDir "$baseDir/calls"

   input:
   path genome from params.genome
   file bamFile from bam_files.collect()
   file baiFile from bai_files.collect()

   output:
   file "all.vcf" into outvcf

   script:
   """
   samtools mpileup -g -f $genome $bamFile | bcftools call -mv - > all.vcf
   """
}
