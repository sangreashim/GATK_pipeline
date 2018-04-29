# $1 == bwa out bam file
# $2 == picard file
# $3 == gatk file
# $4 == reference
#cd $1

#bam=$(echo $1.bam)
bam=$1
echo $bam

gt=$(echo $bam |cut -d '.' -f1)
echo $gt

#mkdir ./temp

#java -Djava.io.tmpdir=./temp/ -Xmx3g -jar $2 AddOrReplaceReadGroups I=$bam O=$bam.addRG.bam SO=coordinate RGID=$gt RGLB=$gt RGPL=illumina RGSM=$gt RGPU=$gt 

#java -Djava.io.tmpdir=./temp/ -Xmx3g -jar $2 MarkDuplicates MAX_FILE_HANDLES_FOR_READ_ENDS_MAP=1000 METRICS_FILE=$gt.out.metrics REMOVE_DUPLICATES=true ASSUME_SORTED=true I=$bam.addRG.bam O=$bam.addRG.bam.dedup.bam

#rm $bam.addRG.bam

#java -Djava.io.tmpdir=./temp/ -Xmx3g -jar $2 FixMateInformation I=$bam.addRG.bam.dedup.bam O=$bam.addRG.bam.dedup.bam.fixmate.bam SO=coordinate

#rm $bam.addRG.bam.dedup.bam

#samtools index $bam.addRG.bam.dedup.bam.fixmate.bam

#java -jar $2/CreateSequenceDictionary.jar R=$4 O=./redbean.ref.dict

#java -Djava.io.tmpdir=./temp/ -Xmx3g -jar $2 ReorderSam I=$bam.addRG.bam.dedup.bam.fixmate.bam O=$bam.addRG.bam.dedup.bam.fixmate.bam.reordered.bam R=$4 CREATE_INDEX=TRUE

#java -Djava.io.tmpdir=./temp/ -Xmx3g -jar $3 -T SplitNCigarReads -U ALLOW_N_CIGAR_READS -rf ReassignOneMappingQuality -fixNDN -R $4 -I $bam.addRG.bam.dedup.bam.fixmate.bam.reordered.bam -o $bam.addRG.bam.dedup.bam.fixmate.bam.reordered.bam.SNCR.bam 

#java -Djava.io.tmpdir=./temp/ -Xmx3g -jar $3 -T RealignerTargetCreator -R $4 -I $bam.addRG.bam.dedup.bam.fixmate.bam.reordered.bam.SNCR.bam -o $gt.intervals

#java -Djava.io.tmpdir=./temp/ -Xmx3g -jar $3 -T IndelRealigner -R $4 -I $bam.addRG.bam.dedup.bam.fixmate.bam.reordered.bam.SNCR.bam -o $bam.addRG.bam.dedup.bam.fixmate.bam.reordered.bam.SNCR.bam.realigned.bam -targetIntervals $gt.intervals

#rm $bam.addRG.bam.dedup.bam.fixmate.bam

#java -Djava.io.tmpdir=./temp/ -Xmx3g -jar $3 -T BaseRecalibrator -o $gt.recal.csv -R $4 -I $bam.addRG.bam.dedup.bam.fixmate.bam.reordered.bam.SNCR.bam.realigned.bam -cov ReadGroupCovariate -cov QualityScoreCovariate -cov CycleCovariate -cov ContextCovariate -U ALLOW_SEQ_DICT_INCOMPATIBILITY --run_without_dbsnp_potentially_ruining_quality

java -Djava.io.tmpdir=./temp/ -Xmx3g -jar $3 -T PrintReads -R $4 -I $bam.addRG.bam.dedup.bam.fixmate.bam.reordered.bam.SNCR.bam.realigned.bam -BQSR $gt.recal.csv -o Recal_$gt.bam

#rm $bam.addRG.bam.dedup.bam.fixmate.bam.realigned.bam

#java -Djava.io.tmpdir=./temp/ -Xmx20g -jar $2 MergeSamFiles I=Recal_$gt.bam O=Integrated.bam SO=coordinate ASSUME_SORTED=true USE_THREADING=true

#rm Recal_$gt.bam

###########################################################################################################################################################################################

#samtools index Integrated.bam

#java -Djava.io.tmpdir=./temp/ -Xmx20g -jar $3 -R $4 -T UnifiedGenotyper -nt 8 -I Integrated.bam -o Integrated.bam.raw.vcf.all.vcf -glm BOTH --output_mode EMIT_ALL_CONFIDENT_SITES

#java -Djava.io.tmpdir=./temp/ -Xmx20g -jar $3 -R $4 -T UnifiedGenotyper -nt 8 -I Integrated.bam -o Integrated.bam.raw.vcf.snp.vcf -glm SNP --output_mode EMIT_VARIANTS_ONLY

#java -Djava.io.tmpdir=./temp/ -Xmx20g -jar $3 -R $4 -T UnifiedGenotyper -nt 8 -I Integrated.bam -o Integrated.bam.raw.vcf.indel.vcf -glm INDEL --output_mode EMIT_VARIANTS_ONLY

#-glm INDEL --output_mode EMIT_VARIANTS_ONLY
#-glm SNP --output_mode EMIT_VARIANTS_ONLY
#-glm BOTH --output_mode EMIT_ALL_CONFIDENT_SITES

#java -Djava.io.tmpdir=./temp/ -Xmx1g -jar /data/program/GenomeAnalysisTK-3.1-1/GenomeAnalysisTK.jar -R ../redbean.ref.fasta -T SelectVariants -nt 8 --variant Integrated.bam.raw.vcf -o snp_Integrated.bam.raw.vcf -selectType SNP

#samtools flagstat $bam >$bam.flagstat
#samtools flagstat Integrated.bam >Integrated.bam.flagstat

#cd ..
