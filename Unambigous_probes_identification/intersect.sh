for f in *_region.txt
do
bedtools intersect -a $f -b repeatMasker -wa -wb > $f.repeatMasker.txt
done

for f in *_region.txt
do
bedtools intersect -a $f -b repeatMasker -wa -wb > $f.repeatMasker.txt
done