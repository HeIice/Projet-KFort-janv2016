#!/bin/bash
TXT_DIR=./texte/
PDF_TO_TEXT=/usr/bin/pdftotext
resolution=300

for PDF_FILE in *.pdf
do
    FILENAME=$(basename "$PDF_FILE")
    # Extraction du contenu textuel avec pdftotext
    PDF2TXT_FILE=$TXT_DIR/${FILENAME%.*}.pdf2txt
    TXT_FILE=$TXT_DIR/${FILENAME%.*}.txt
    if [ -f $TXT_FILE ]
    then
        continue
    fi
    echo "$PDF_TO_TEXT -layout -enc UTF-8 $PDF_FILE $PDF2TXT_FILE"
    $PDF_TO_TEXT -layout -enc UTF-8 $PDF_FILE $PDF2TXT_FILE

    # Test si le contenu textuel n'est pas correct, OCR
    NB_ET=$(grep -c 'et' $PDF2TXT_FILE)
    if (( $NB_ET < 5 ))
    then
        mkdir $IMG_DIR
        rm -f $PDF2TXT_FILE

        # Conversion du fichier pdf en images
        echo "convert -density $resolution $PDF_FILE $IMG_DIR/${FILENAME%.*}.jpg"
        convert -density $resolution $PDF_FILE $IMG_DIR/${FILENAME%.*}.jpg
    fi
    #     # Calcul du nombre de pages
    #     NUMPAGES=$(ls $IMG_DIR/*.jpg | wc -l)
    #     NUMPAGES=$((NUMPAGES-1))

    #     echo "NUMPAGES" $NUMPAGES

    #     # Si le nombre de page est supérieur à 1
    #     if (( $NUMPAGES > 1 ))
    #     then

    #         # OCR des fichiers images
    #         for PAGE in $(eval echo {0..$NUMPAGES})
    #         do
    #             IMG_FILE=$IMG_DIR/${FILENAME%.*}-$PAGE.jpg
    #             echo "tesseract $IMG_FILE ${IMG_FILE%.*}"
    #             tesseract $IMG_FILE ${IMG_FILE%.*}
    #             echo "cat ${IMG_FILE%.*}.txt >> $PDF2TXT_FILE"
    #             cat ${IMG_FILE%.*}.txt >> $PDF2TXT_FILE
    #             rm ${IMG_FILE%.*}.txt
    #             rm $IMG_FILE
    #         done

    #         # Si il y a une page
    #     else
    #         IMG_FILE=$IMG_DIR/${FILENAME%.*}.jpg
    #         echo "tesseract $IMG_FILE $IMG_FILE"
    #         tesseract $IMG_FILE $IMG_FILE
    #         mv $IMG_FILE.txt $PDF2TXT_FILE
    #         rm $IMG_FILE
    #     fi

    #     rmdir $IMG_DIR
    # fi

    # # Nettoyage du contenu textuel 
    # python clean_text_output.py $PDF2TXT_FILE $TXT_FILE
    # rm -f $PDF2TXT_FILE

done
