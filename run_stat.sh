#       $1      all_vcf
#       $2      snp_vcf
#       $3      indel_vcf
#       $4      snp_pep
#       $5      indel_cds
#       $6      in-frame-shift.py
#	$7	[vcf]in-frame-shift-forGene.py

#sh statistics.sh Integrated.bam.raw.vcf.all.vcf.DPflt.filtered.passed Integrated.bam.raw.vcf.snp.vcf.DPflt.filtered.passed.varType Integrated.bam.raw.vcf.indel.vcf.DPflt.filtered.passed.varType Integrated.bam.raw.vcf.snp.vcf.DPflt.filtered.passed.varType.pep Integrated.bam.raw.vcf.indel.vcf.DPflt.filtered.passed.varType.cds ~/pythonCode/[vcf]in-frame-shift.py > statistics.sh.out

sh statistics.sh $1 $2 $3 $4 $5 $6 > statistics.sh.out

#sh statistics_gene.sh Integrated.bam.raw.vcf.indel.vcf.DPflt.filtered.passed.varType Integrated.bam.raw.vcf.snp.vcf.DPflt.filtered.passed.varType Integrated.bam.raw.vcf.indel.vcf.DPflt.filtered.passed.varType.cds ~/pythonCode/[vcf]in-frame-shift-forGene.py > statistics_gene.sh.out

sh statistics_gene.sh $3 $2 $5 $7 > statistics_gene.sh.out
