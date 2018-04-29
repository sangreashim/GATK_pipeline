# GATK_pipeline

integrated GATK pipeline, easy to use to call variants using GATK.

prerequsites

NGSQCToolkit,GATK, Picard

Procedure

# (Optional) Step 0. execute_readFilter.sh
execute_readFilter.sh (dir. of fastq file) (full path of NGSQCToolKit/IlluQC.pl)

# Step 1. run_alignBWA.sh
run_alignBWA.sh bwa_reference cohort NGS_dir

# Step 2. gatk_pipe.sh
gatk_pipe.sh BAM picard_dir gatk_dir reference_fasta
flagstat.sh BAM BAM

# Step 4. gatk_pipe_variation_validation.sh 
gatk_pipe_variation_validation.sh vcf picard_dir gatk_dir reference_fasta maxDP(averageCov*2)
parallel sh gatk_pipe_variation_validation.sh {} picard_dir gatk_dir reference_fasta maxDP(averageCov*2) ::: *.vcf

# Step 5. run_varTyping.sh
run_varTyping.sh ref_fasta primary_gff indel_vcf snp_vcf

# Step 6. run_stat.sh
run_stat.sh all_vcf snp_vcf indel_vcf snp_vcf_pep indel_vcf_cds [vcf]in-frame-shift.py [vcf]in-frame-shift-forGene.py
