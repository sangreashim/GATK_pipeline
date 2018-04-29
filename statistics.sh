#	$1	all_vcf
#	$2	snp_vcf
#	$3	indel_vcf
#	$4	snp_pep
#	$5	indel_cds
#	$6	in-frame-shift.py

echo 'Total mapped positions'
grep -v '#' $1 |wc -l
##################################################
echo 'SNP'
grep -v '#' $2 |wc -l

echo 'Intergenic'
grep -v '#' $2 |grep 'Intergenic' |wc -l

echo 'Total genic'
grep -v '#' $2 |grep -v 'Intergenic' |wc -l

echo '5 UTR'
grep -v '#' $2 |grep 'UTR5' |wc -l

echo 'Syn'
grep -v '#' $2 |grep '|syn' |wc -l

echo 'Non-syn'
grep -v '#' $2 |grep '|non' |wc -l

echo '3 UTR'
grep -v '#' $2 |grep 'UTR3' |wc -l

echo 'Intron'
grep -v '#' $2 |grep 'Intron' |wc -l
#################################################
echo 'INDEL'
grep -v '#' $3 |wc -l

echo 'Intergenic'
grep -v '#' $3 |grep 'Intergenic' |wc -l

echo 'Total genic'
grep -v '#' $3 |grep -v 'Intergenic' |wc -l

echo '5 UTR'
grep -v '#' $3 |grep 'UTR5' |wc -l

echo 'In-Frame-Shift'
python $6 $5

echo '3 UTR'
grep -v '#' $3 |grep 'UTR3' |wc -l

echo 'Intron'
grep -v '#' $3 |grep 'Intron' |wc -l
##################################################
echo "coding2stop.txt"
grep -F -f ~/peptide_change/coding2stop.txt $4 |wc -l

echo "stop2coding.txt"
grep -F -f ~/peptide_change/stop2coding.txt $4 |wc -l

echo "hydro2basic.txt"
grep -F -f ~/peptide_change/hydro2basic.txt $4 |wc -l

echo "hydro2acidic.txt"
grep -F -f ~/peptide_change/hydro2acidic.txt $4 |wc -l

echo "hydro2polar.txt"
grep -F -f ~/peptide_change/hydro2polar.txt $4 |wc -l

echo "basic2hydro.txt"
grep -F -f ~/peptide_change/basic2hydro.txt $4 |wc -l

echo "acidic2hydro.txt"
grep -F -f ~/peptide_change/acidic2hydro.txt $4 |wc -l

echo "polar2hydro.txt"
grep -F -f ~/peptide_change/polar2hydro.txt $4 |wc -l
##################################################
