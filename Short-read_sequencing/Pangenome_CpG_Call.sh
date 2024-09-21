vg giraffe -t 14 -Z /home/zdong01/scratch/Pan/Trim_galore/Reference/index.giraffe.gbz -m /home/zdong01/scratch/Pan/Trim_galore/Reference/index.min -d /home/zdong01/scratch/Pan/Trim_galore/Reference/index.dist -f ../SRR10077441_1_val_1.fq.gz -f ../SRR10077441_2_val_2.fq.gz -o BAM > SRR10077441_trimmed.mapped.bam
/home/zdong01/anaconda3/envs/Samtools/bin/samtools sort SRR10077441_trimmed.mapped.bam -o SRR10077441_sorted.bam
/home/zdong01/anaconda3/envs/Samtools/bin/samtools consensus -o SRR10077441.fa SRR10077441_sorted.bam
rm SRR10077441_sorted.bam
grep -o "CG" SRR10077441.fa | wc -l




