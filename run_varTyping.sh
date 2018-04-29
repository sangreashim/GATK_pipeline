#       $1      ref_fasta
#       $2      primary_gff
#       $3      indel_vcf
#	$4	snp_vcf
#python ~/pythonCode/\[SNP\]variation_type_Nonphytozome.py ~/ref/redbean.ref.fasta ~/ref/Redbean.scaffold.gff3.sort.gff3.primary.gff3 Integrated.bam.raw.vcf.indel.vcf.DPflt.filtered.passed

python ~/pythonCode/\[SNP\]variation_type_Nonphytozome.py $1 $2 $3
python ~/pythonCode/\[SNP\]variation_type_Nonphytozome.py $1 $2 $4

python ~/pythonCode/\[vcf\]referencePep2altPep.py $4.varType
grep ':cds' $3.varType > $3.varType.cds
