#!/usr/bin/sh

## argv1 is directory stores fastq.gz files

for i in `ls $1`
do
echo $i ' is now quality checking!!'
file_name=$(echo $i |cut -d '.' -f 1)
echo $file_name
fastqc_dir=${file_name}'_fastqc'
echo $fastqc_dir
mkdir $1/$fastqc_dir
fastqc $1/$i -o $1/$fastqc_dir/
done
