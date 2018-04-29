# $1 == directory of bam file saved
# $2 == picard path
# $3 == full path of gatk.jar file
# $4 == full path of reference

cd $1
for file_name in `ls *.fastq.gz | cut -f 1 -d '_' | sort -u`
do
bam=$file_name'.bam'
echo $bam
gt=$(echo $bam |cut -d '.' -f1)
echo $gt
mkdir ./temp
java -Djava.io.tmpdir=./temp/ -Xmx3g -jar $2/AddOrReplaceReadGroups.jar I=$bam O=$bam.addRG.bam SO=coordinate RGID=$gt RGLB=$gt RGPL=illumina RGSM=$gt RGPU=$gt 
java -Djava.io.tmpdir=./temp/ -Xmx3g -jar $2/MarkDuplicates.jar MAX_FILE_HANDLES_FOR_READ_ENDS_MAP=1000 METRICS_FILE=$gt.out.metrics REMOVE_DUPLICATES=true ASSUME_SORTED=true I=$bam.addRG.bam O=$bam.addRG.bam.dedup.bam
#rm $bam.addRG.bam
java -Djava.io.tmpdir=./temp/ -Xmx3g -jar $2/FixMateInformation.jar I=$bam.addRG.bam.dedup.bam O=$bam.addRG.bam.dedup.bam.fixmate.bam SO=coordinate
#rm $bam.addRG.bam.dedup.bam
samtools index $bam.addRG.bam.dedup.bam.fixmate.bam
java -jar $2/CreateSequenceDictionary.jar R=$4 O=$4.redbean.ref.dict
java -Djava.io.tmpdir=./temp/ -Xmx3g -jar $3 -T RealignerTargetCreator -R $4 -fixMisencodedQuals -I $bam.addRG.bam.dedup.bam.fixmate.bam -o $gt.intervals
java -Djava.io.tmpdir=./temp/ -Xmx3g -jar $3 -T IndelRealigner -R $4 -fixMisencodedQuals -I $bam.addRG.bam.dedup.bam.fixmate.bam -o $bam.addRG.bam.dedup.bam.fixmate.bam.realigned.bam -targetIntervals $gt.intervals
#rm $bam.addRG.bam.dedup.bam.fixmate.bam
java -Djava.io.tmpdir=./temp/ -Xmx3g -jar $3 -T BaseRecalibrator -o $gt.recal.csv -R $4 -I $bam.addRG.bam.dedup.bam.fixmate.bam.realigned.bam -cov ReadGroupCovariate -cov QualityScoreCovariate -cov CycleCovariate -cov ContextCovariate -U ALLOW_SEQ_DICT_INCOMPATIBILITY --run_without_dbsnp_potentially_ruining_quality
java -Djava.io.tmpdir=./temp/ -Xmx3g -jar $3 -T PrintReads -R $4 -I $bam.addRG.bam.dedup.bam.fixmate.bam.realigned.bam -BQSR $gt.recal.csv -o Recal_$gt.bam
#rm $bam.addRG.bam.dedup.bam.fixmate.bam.realigned.bam
done
cd ..
