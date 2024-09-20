cat Filter.p.Probes_A.genome_mfa.GA_conversion.fa.psl Filter.n.Probes_A.genome_mfa.CT_conversion.fa.psl | cut -f10 | sort | uniq -u > a.log
cat Filter.n.Probes_B.genome_mfa.CT_conversion_onlyCGprotection.fa.psl Filter.p.Probes_B.genome_mfa.GA_conversion_onlyCGprotection.fa.psl | cut -f10 | sort | uniq -u > b.log
sed -i 's/G/F/g' b.log
sed -i "s/A/F/g" a.log
cat Filter.p.Probes_A.genome_mfa.CT_conversion_reversecomplement.fa.psl Filter.n.Probes_B.genome_mfa.GA_conversion_onlyCGprotection_reversecomplement.fa.psl Filter.n.Probes_A.genome_mfa.GA_conversion_reversecomplement.fa.psl Filter.n.Probes_A.genome_mfa.GA_conversion.fa.psl Filter.n.Probes_B.genome_mfa.GA_conversion_onlyCGprotection.fa.psl Filter.p.Probes_A.genome_mfa.CT_conversion.fa.psl Filter.p.Probes_B.genome_mfa.CT_conversion_onlyCGprotection.fa.psl Filter.p.Probes_B.genome_mfa.CT_conversion_onlyCGprotection_reversecomplement.fa.psl | cut -f10 | sort  > c.log
sed -i 's/A/F/g' c.log
sed -i "s/G/F/g" c.log
comm -12 <( sort a.log ) <( sort b.log ) > d.log
comm -23 <( sort d.log ) <( sort c.log ) > probes_human.txt


