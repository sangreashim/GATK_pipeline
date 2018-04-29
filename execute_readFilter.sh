# $1 directory of NGS file saved
# $2 full path of IlluQC.pl

sh NGS_QC.sh $1 2> NGS_QC.sh.out
sh NGS_QF.sh $1 $2 2> NGS_QF.sh.out
