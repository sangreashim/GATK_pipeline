#	$1	vcf
#	$2	picard
#	$3	gatk
#	$4	reference.fa
#	$5	maxDP == averageCov*2

python ~/pythonCode/\[vcf\]depth_filter_allPosition.py $1 0 $5 

echo 'gaTK filter variation from '$1'. reference is '$4

java -Djava.io.tmpdir=./temp/ -Xmx18g -jar $3/GenomeAnalysisTK.jar -R $4 -T VariantFiltration --variant $1.DPflt -o $1.DPflt.filtered --filterExpression "MQ0 >= 4 && ((MQ0 / (1.0*DP))>0.1)" --filterName "HARD_TO_VALIDATE" --filterExpression "QUAL<30" --filterName "QualFilter"
grep 'PASS' $1.DPflt.filtered > $1.DPflt.filtered.passed
