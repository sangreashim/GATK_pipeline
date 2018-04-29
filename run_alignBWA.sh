#	$1	bwa_reference
#	$2	cohort
#	$3	NGS_dir

bwa index $1 $1

mkdir $2
cd $3

echo '##################################### Mapping '$2' #####################################' 

paired1=$(echo $2'_1.fastq.gz')
paired2=$(echo $2'_2.fastq.gz')

bwa mem -t 4 -M $1 $paired1 $paired2 | samtools view -bS - > ../$2/$2.bam

cd ../

cp gatk_pipe.sh $2/
cp gatk_pipe_variation_validation.sh $2/
cp run_varTyping.sh $2/
cp run_stat.sh $2/

#bwa sampe ../ref/redbean.ref.fasta ./V_nakashimae_2_1.fastq.gz.sai ./V_nakashimae_2_2.fastq.gz.sai ./V_nakashimae_2_1.fastq.gz ./V_nakashimae_2_2.fastq.gz | samtools view -bS - > ./V_nakashimae_2_1.bam

echo '#####################################'

#samtools faidx ../redbean.ref.fasta

#echo '#####################################'

#samtools import /data1/kev8305/ysp_resequencing/redbean.ref.fasta.fai ./ysp-2.fastq.gz.sam ./ysp-2.fastq.gz.sam.bam

#echo '#####################################'


