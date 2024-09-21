bowtie2 -q --phred33 --sensitive -X 500 -p 2 -t -x /home/zdong01/scratch/zdong01/T2T/T2T-CHM13V2.0/bowtie2/T2T -U /home/zdong01/scratch/zdong01/T2T/Sequence-based/Trim_galore/SRR500520_trimmed.fq.gz  | samtools view -bhSo SRR500520_unsorted.bam -
samtools view -b -F 1804 -q 2 SRR500520_unsorted.bam > SRR500520_unsorted1.bam
samtools sort SRR500520_unsorted1.bam -o SRR500520.sorted.bam
java -Xmx8g -jar /home/zdong01/projects/def-koborlab/zdong01/Softwares/picard/picard.jar MarkDuplicates REMOVE_DUPLICATES=true  INPUT=SRR500520.sorted.bam OUTPUT=SRR500520.sorted_nodups.bam ASSUME_SORTED=true METRICS_FILE=Picard_SRR500520_duplicates.txt
samtools index SRR500520.sorted_nodups.bam
samstat SRR500520.sorted_nodups.bam
bam stats --in SRR500520.sorted_nodups.bam --basic --bamIndex SRR500520.sorted_nodups.bam.bai
source ~/MyPythonEnv/bin/activate
macs3 callpeak -t SRR500520.sorted_nodups.bam -f BAM -g 3030000000 -n SRR500520 -B -q 0.05 --outdir peak
bamToBed -i SRR500520.sorted_nodups.bam > SRR500520.reads.bed
