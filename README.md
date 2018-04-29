# GATK_pipeline

integrated GATK pipeline, easy to use to call variants using GATK.

prerequsites:
NGSQCToolkit, bwa, samtools, GATK, Picard

Procedure

# (Optional) Step 0. execute_readFilter.sh
execute_readFilter.sh (dir. of fastq file saved) (full path of NGSQCToolKit/IlluQC.pl)

# Step 1. run_alignBWA.sh
run_alignBWA.sh (bwa_reference_file) (dir. of fastq file saved)

# Step 2. gatk_pipe.sh
gatk_pipe.sh (dir. of bam file saved) (path of picard software) (full apth of gatk.jar) (reference_fasta)
gatk_pipe_variationCall.sh (dir. of bam file saved) (path of picard software) (full apth of gatk.jar) (reference_fasta)

# Step 4. gatk_pipe_variation_validation.sh 
gatk_pipe_variation_validation.sh (vcf file) (path of picard software) (full apth of gatk.jar) (reference_fasta)
