# convert a,t,c,g to A,T,C,G
sed -i -e 's/a/A/g' ref.fna
sed -i -e 's/t/T/g' ref.fna
sed -i -e 's/c/C/g' ref.fna
sed -i -e 's/g/G/g' ref.fna

## ==== C -> T concersion ======
sed 's/CG/QG/g' ref.fna > GCF_000151905.2_gorGor4_genomic_CGtoBG.fasta

sed 's/C/T/g' ref.fna > genome_mfa.CT_conversion.fa
# sed -i 's/NT_/NC_/g' genome_mfa.CT_conversion.fa
# sed -i 's/GRTh37/GRCh37/g' genome_mfa.CT_conversion.fa

sed 's/C/T/g' GCF_000151905.2_gorGor4_genomic_CGtoBG.fasta > genome_mfa.CT_conversion_onlyCGprotection.fa
# sed -i 's/NT_/NC_/g' genome_mfa.CT_conversion_onlyCGprotection.fa
# sed -i 's/GRTh37/GRCh37/g' genome_mfa.CT_conversion_onlyCGprotection.fa
sed -i 's/QG/CG/g' genome_mfa.CT_conversion_onlyCGprotection.fa

cp genome_mfa.CT_conversion_onlyCGprotection.fa genome_mfa.CT_conversion_onlyCGprotection_reversecomplement.fa
## change input for reversecomplement.sh before doing this
## check 'W' in reference genome
bash ../reversecomplement1.sh

cp genome_mfa.CT_conversion.fa genome_mfa.CT_conversion_reversecomplement.fa
## change input for reversecomplement.sh before doing this
bash ../reversecomplement2.sh

## ==== G -> A concersion ======
sed 's/CG/CQ/g' ref.fna > GCF_000151905.2_gorGor4_genomic_CGtoCB.fasta

sed 's/G/A/g' ref.fna > genome_mfa.GA_conversion.fa
# sed -i 's/NT_/NC_/g' genome_mfa.CT_conversion.fa
# sed -i 's/GRTh37/GRCh37/g' genome_mfa.CT_conversion.fa

sed 's/G/A/g' GCF_000151905.2_gorGor4_genomic_CGtoCB.fasta > genome_mfa.GA_conversion_onlyCGprotection.fa
# sed -i 's/NT_/NC_/g' genome_mfa.CT_conversion_onlyCGprotection.fa
# sed -i 's/GRTh37/GRCh37/g' genome_mfa.CT_conversion_onlyCGprotection.fa
sed -i 's/CQ/CG/g' genome_mfa.GA_conversion_onlyCGprotection.fa

cp genome_mfa.GA_conversion_onlyCGprotection.fa genome_mfa.GA_conversion_onlyCGprotection_reversecomplement.fa
## change input for reversecomplement.sh before doing this
## check 'W' in reference genome
bash ../reversecomplement3.sh

cp genome_mfa.GA_conversion.fa genome_mfa.GA_conversion_reversecomplement.fa
## change input for reversecomplement.sh before doing this
bash ../reversecomplement4.sh

