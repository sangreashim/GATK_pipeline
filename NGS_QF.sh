#!/usr/bin/sh

## argv1 is directory stores fastq.gz files
## argv2 is directory stores IlluQC.pl

for file_name in 'V_nepal_1_' 'V_nipp_1_'
do

echo $file_name' is now on quality filering!!'

ngstoolkit_dir=$(echo $file_name'ngstoolkit')
echo $ngstoolkit_dir

mkdir $1/$ngstoolkit_dir

first_file=$1/${file_name}'1.fastq.gz'
second_file=$1/${file_name}'2.fastq.gz'

perl $2 -pe $first_file $second_file N A -o $1/$ngstoolkit_dir -p 4 -t 2 -z g
done
