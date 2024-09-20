bedtools intersect -a 450k.bed -b ~/KoborLab/kobor_space/zdong/T2T/Sequence-based/Cancer/10X/Genomic_features/Promoter -wa -wb > Promoter.t2t.bed

bedtools intersect -a 450k.bed -b ~/KoborLab/kobor_space/zdong/T2T/Sequence-based/Cancer/Annotation/catLiftOffGenesV1 -wa -wb > Gene.t2t.bed

bedtools intersect -a 450k.bed -b ~/KoborLab/kobor_space/zdong/T2T/Sequence-based/Cancer/Annotation/cpgisland -wa -wb > CGI.t2t.bed

bedtools intersect -a 450k.bed -b  cpg_shore.bed -wa -wb > cpg_shore.t2t.bed

bedtools intersect -a 450k.bed -b cpg_shelf.bed -wa -wb > cpg_shelf.t2t.bed