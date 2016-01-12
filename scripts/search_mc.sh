#!/bin/sh

if test -z "$1" 
then
     echo "USAGE : Spécifier le répertoire contenant les fichiers .txt à traiter (TALN, total-articles-Maurel...)"
exit 0
fi


COUNT_DIR=../result-count/$1/count-mc
FILE_DIR=../result-count/$1/file-mc
TXT_DIR=../articles/$1/txt

echo "recherche de mots clés sur un total de" 
eval "ls $TXT_DIR | wc -l" 
echo "fichiers"


while read p; do
	echo $p
eval "grep -li '$p' $TXT_DIR/*txt | wc -l"
#eval "grep -li '$p' new_txt/*"
eval "grep -li '$p' $TXT_DIR/*txt | wc -l" > $COUNT_DIR/count_$p.txt
eval "grep -li '$p' $TXT_DIR/*txt" > $FILE_DIR/file_$p.txt
done < mots-cles-alpha.txt
