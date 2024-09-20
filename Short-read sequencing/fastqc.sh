cd /home/zdong01/scratch/zdong01/T2T/Sequence-based/
#files=(SRR13051111_2.fastq SRR13051084_2.fastq SRR13051078_2.fastq SRR13051071_2.fastq SRR13051104_2.fastq SRR13051098_2.fastq SRR13051091_2.fastq SRR13051111_1.fastq SRR13051084_1.fastq SRR13051078_1.fastq SRR13051071_1.fastq SRR13051104_1.fastq SRR13051098_1.fastq SRR13051091_1.fastq SRR15046849.fastq)
files=(SRR1097452.fastq SRR1097453.fastq SRR1097489.fastq SRR1237957.fastq SRR15242572_1.fastq SRR15242572_2.fastq SRR3469520_1.fastq SRR3469520_2.fastq SRR500520.fastq SRR500521.fastq SRR500522.fastq SRR5125815.fastq Brain_MeDIP.fq Brain_MRE.fq H1Es_MeDIP.fq H1Es_MRE.fq)
for file in ${files[@]};
  do fastqc $file --outdir /home/zdong01/scratch/zdong01/T2T/Sequence-based/QC
done
