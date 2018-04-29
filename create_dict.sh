# $1 path of picard
# $2 reference genome sequence file

java -jar $1/CreateSequenceDictionary.jar R=$2 O=./redbean.ref.dict
