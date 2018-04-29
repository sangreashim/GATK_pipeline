#!/usr/bin/sh

## argv1 is directory stores fastq.gz files
## argv2 is full path of IlluQC.pl

cd $1
ls *.fastq.gz | cut -f 1 -d '_' | sort -u > fastq_header

for file_name in $(cat "fastq_header")
do
echo $file_name' is now on quality filering!!'
ngstoolkit_dir=$(echo $file_name'_ngstoolkit')
echo $ngstoolkit_dir
mkdir $ngstoolkit_dir
first_file=${file_name}'_1.fastq.gz'
second_file=${file_name}'_2.fastq.gz'
perl $2 -pe $first_file $second_file N A -o $ngstoolkit_dir -p 4 -t 2 -z g
done

cd ..
