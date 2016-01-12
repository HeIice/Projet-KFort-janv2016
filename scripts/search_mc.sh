#!/bin/sh

COUNT_DIR=../result-count/$1/count-mc
FILE_DIR=../result-count/$1/file-mc
TXT_DIR=../articles/$1/txt

while read p; do
	echo $p
eval "grep -li '$p' $TXT_DIR/*txt | wc -l"
#eval "grep -li '$p' new_txt/*"
eval "grep -li '$p' $TXT_DIR/*txt | wc -l" > $COUNT_DIR/count_$p.txt
eval "grep -li '$p' $TXT_DIR/*txt" > $FILE_DIR/file_$p.txt
done < mots_clé.txt
