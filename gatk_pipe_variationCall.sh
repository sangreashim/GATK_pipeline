# $1 == directory of bam file saved
# $2 == picard file
# $3 == gatk file
# $4 == reference

cd $1

java -Djava.io.tmpdir=./temp/ -Xmx20g -jar $2/MergeSamFiles.jar $(ls Recal*.bam | tr '\n' ' ' | sed 's/Recal/I=Recal/g') O=Integrated.bam SO=coordinate ASSUME_SORTED=true USE_THREADING=true

samtools index Integrated.bam

java -Djava.io.tmpdir=./temp/ -Xmx20g -jar $3 -R $4 -T UnifiedGenotyper -nt 8 -I Integrated.bam -o Integrated.bam.raw.vcf.all.vcf -glm BOTH --output_mode EMIT_ALL_CONFIDENT_SITES

java -Djava.io.tmpdir=./temp/ -Xmx20g -jar $3 -R $4 -T UnifiedGenotyper -nt 8 -I Integrated.bam -o Integrated.bam.raw.vcf.snp.vcf -glm SNP --output_mode EMIT_VARIANTS_ONLY

java -Djava.io.tmpdir=./temp/ -Xmx20g -jar $3 -R $4 -T UnifiedGenotyper -nt 8 -I Integrated.bam -o Integrated.bam.raw.vcf.indel.vcf -glm INDEL --output_mode EMIT_VARIANTS_ONLY

cd ../

#java -Djava.io.tmpdir=./temp/ -Xmx1g -jar /data/program/GenomeAnalysisTK-3.1-1/GenomeAnalysisTK.jar -R ../redbean.ref.fasta -T SelectVariants -nt 8 --variant Integrated.bam.raw.vcf -o snp_Integrated.bam.raw.vcf -selectType SNP
#samtools flagstat $bam >$bam.flagstat
#samtools flagstat Integrated.bam >Integrated.bam.flagstat
