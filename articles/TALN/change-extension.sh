#!/bin/sh

for f in *[0-9].pdf; do 
echo "$f"
mv -- "$f" "${f%.pdf}-Fort.pdf"
done
