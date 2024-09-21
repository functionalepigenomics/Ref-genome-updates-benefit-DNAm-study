bowtie2 -q --phred33 --sensitive -X 500 -p 4 -t -x /home/zdong01/scratch/zdong01/T2T/GRCh38.p13/bowtie2/GRCh38 -1 /home/zdong01/scratch/zdong01/T2T/Sequence-based/Trim_galore/H1Es_MeDIP_1_val_1.fq.gz -2 /home/zdong01/scratch/zdong01/T2T/Sequence-based/Trim_galore/H1Es_MeDIP_2_val_2.fq.gz -S H1Es_MeDIP.sam
samtools view H1Es_MeDIP.sam -bhSo H1Es_MeDIP_unsorted.bam
samtools view -b -F 1804 -q 2 H1Es_MeDIP_unsorted.bam > H1Es_MeDIP_unsorted1.bam
samtools sort H1Es_MeDIP_unsorted1.bam -o H1Es_MeDIP_sorted.bam
java -Xmx8g -jar /home/zdong01/projects/def-koborlab/zdong01/Softwares/picard/picard.jar MarkDuplicates REMOVE_DUPLICATES=true  INPUT=H1Es_MeDIP_sorted.bam OUTPUT=H1Es_MeDIP.sorted_nodups.bam ASSUME_SORTED=true METRICS_FILE=Picard_H1Es_MeDIP_duplicates.txt
samtools index H1Es_MeDIP.sorted_nodups.bam
samstat H1Es_MeDIP.sorted_nodups.bam
bam stats --in H1Es_MeDIP.sorted_nodups.bam --basic --bamIndex H1Es_MeDIP.sorted_nodups.bam.bai
source ~/MyPythonEnv/bin/activate
macs3 callpeak -t H1Es_MeDIP.sorted_nodups.bam -f BAM -g 2790000000 -n H1Es_MeDIP_MeDIP -B -q 0.05 --outdir peak
bamToBed -i H1Es_MeDIP.sorted_nodups.bam > H1Es_MeDIP.reads.bed


