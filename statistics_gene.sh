#	$1 indel.passed
#	$2 snp.passed
#	$3 indel.passed.cds
#	$4 [vcf]in_frame_shift-forGene.py
echo "indel"
grep -v 'Intergenic' $1 |cut -f 11 |tr ',' '\n' |grep 'mRNA' |cut -d '.' -f 1 |sort -u |wc -l
echo "5utr"
grep -v 'Intergenic' $1 |cut -f 11 |tr ',' '\n' |grep 'UTR5' |cut -d '.' -f 1 |sort -u |wc -l
echo "inframe-shift"
python $4 $3
echo "3utr"
grep -v 'Intergenic' $1 |cut -f 11 |tr ',' '\n' |grep 'UTR3' |cut -d '.' -f 1 |sort -u |wc -l
echo "intron"
grep -v 'Intergenic' $1 |cut -f 11 |grep 'Intron' |tr 'm' '\n' |grep 'Intron' |cut -d '.' -f 1 |sort -u |wc -l

echo "snp"
grep -v 'Intergenic' $2 |cut -f 11 |tr ',' '\n' |grep 'mRNA' |cut -d '.' -f 1 |sort -u |wc -l
echo "5utr"
grep -v 'Intergenic' $2 |cut -f 11 |tr ',' '\n' |grep 'UTR5' |cut -d '.' -f 1 |sort -u |wc -l
echo "syn"
grep -v 'Intergenic' $2 |cut -f 11 |tr ',' '\n' |grep '|syn' |cut -d '.' -f 1 |sort -u |wc -l
echo "non-syn"
grep -v 'Intergenic' $2 |cut -f 11 |tr ',' '\n' |grep '|non' |cut -d '.' -f 1 |sort -u |wc -l
echo "3utr"
grep -v 'Intergenic' $2 |cut -f 11 |tr ',' '\n' |grep 'UTR3' |cut -d '.' -f 1 |sort -u |wc -l
echo "intron"
grep -v 'Intergenic' $2 |cut -f 11 |grep 'Intron' |tr 'm' '\n' |grep 'Intron' |cut -d '.' -f 1 |sort -u |wc -l
