for file in ../SRR3274347_1_val_1_bismark_bt2_pe.bam # ../SRR3274347_trimmed_bismark_bt2.bam 
	do deduplicate_bismark --bam $file --output_dir ./
	done
bash filter_non_conversion.sh
filter_non_conversion -p SRR3274347_1_val_1_bismark_bt2_pe.deduplicated.bam
bismark_methylation_extractor --multicore 10 -p --comprehensive --merge_non_CpG --bedGraph --counts --buffer_size 10G --no_overlap --gzip SRR3274347_1_val_1_bismark_bt2_pe.deduplicated.nonCG_filtered.bam --output ./ 
coverage2cytosine --merge_CpG --genome_folder /home/zdong01/scratch/zdong01/T2T/T2T-CHM13V2.0/ncbi-genomes-2022-07-08 -o SRR3274347 SRR3274347_1_val_1_bismark_bt2_pe.deduplicated.nonCG_filtered.bismark.cov.gz #  SRR3274347_trimmed_bismark_bt2.deduplicated.nonCG_filtered.bismark.cov.gz #SRR3274347_1_val_1_bismark_bt2_pe.deduplicated.nonCG_filtered.bismark.cov.gz


