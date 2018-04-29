#       $1      bwa_reference
#       $2      NGS_dir

#bwa index $1 $1
cd $2

for file_name in `ls *.fastq.gz | cut -f 1 -d '_' | sort -u`
do
echo '##################################### Mapping '$2' #####################################' 
paired1=$file_name'_1.fastq.gz'
paired2=$file_name'_2.fastq.gz'
bwa mem -t 4 -M $1 $paired1 $paired2 | samtools view -bS - > $file_name.bam
done
cd ../
