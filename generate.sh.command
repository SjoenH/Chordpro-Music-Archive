#!/bin/bash

# Change directory to where this file is at.
cd "$(dirname "$0")"

echo -e "\n\033[0;32m Hello! \n Let's Convert some files. \033[0m" &
[ -d "PDF" ] || mkdir PDF

# # Gå inn i txt mappen med alle chordpro.txt-filene
cd TXT

if [ -d "temp" ]; then
    rm -rf temp
fi
mkdir temp

for f in *.txt; do
    cp "$f" temp/ &
done

echo -e "\n\033[0;32m Songs to convert: \n \033[0m"
cd temp
ls

# Generer pdf-er for hver fil som er av type .txt,  vha. chordpro-programmet
echo -e "\n\033[0;32m Generating PDFS. This might take a while... \033[0m"
for f in *.txt; do
    {
        chordpro "$f" -x 0 -o "${f%.txt}+00.pdf"
        mv "${f%.txt}+00.pdf" ../../PDF/
    } &
    pidlist="$pidlist $!"
    {
        chordpro "$f" -x 1 -o "${f%.txt}+01.pdf"
        mv "${f%.txt}+01.pdf" ../../PDF/
    } &
    pidlist="$pidlist $!"
    {
        chordpro "$f" -x 2 -o "${f%.txt}+02.pdf"
        mv "${f%.txt}+02.pdf" ../../PDF/
    } &
    pidlist="$pidlist $!"
    {
        chordpro "$f" -x 3 -o "${f%.txt}+03.pdf"
        mv "${f%.txt}+03.pdf" ../../PDF/
    } &
    pidlist="$pidlist $!"
    {
        chordpro "$f" -x 4 -o "${f%.txt}+04.pdf"
        mv "${f%.txt}+04.pdf" ../../PDF/
    } &
    pidlist="$pidlist $!"
    {
        chordpro "$f" -x 5 -o "${f%.txt}+05.pdf"
        mv "${f%.txt}+05.pdf" ../../PDF/
    } &
    pidlist="$pidlist $!"
    {
        chordpro "$f" -x 6 -o "${f%.txt}+06.pdf"
        mv "${f%.txt}+06.pdf" ../../PDF/
    } &
    pidlist="$pidlist $!"
    {
        chordpro "$f" -x 7 -o "${f%.txt}+07.pdf"
        mv "${f%.txt}+07.pdf" ../../PDF/
    } &
    pidlist="$pidlist $!"
    {
        chordpro "$f" -x 8 -o "${f%.txt}+08.pdf"
        mv "${f%.txt}+08.pdf" ../../PDF/
    } &
    pidlist="$pidlist $!"
    {
        chordpro "$f" -x 9 -o "${f%.txt}+09.pdf"
        mv "${f%.txt}+09.pdf" ../../PDF/
    } &
    pidlist="$pidlist $!"
    {
        chordpro "$f" -x 10 -o "${f%.txt}+10.pdf"
        mv "${f%.txt}+10.pdf" ../../PDF/
    } &
    pidlist="$pidlist $!"
    {
        chordpro "$f" -x 11 -o "${f%.txt}+11.pdf"
        mv "${f%.txt}+11.pdf" ../../PDF/
    } &
    pidlist="$pidlist $!"
    {
        chordpro "$f" -l -o "${f%.txt}+lyrics.pdf"
        mv "${f%.txt}+lyrics.pdf" ../../PDF/
    } &
    pidlist="$pidlist $!"
done

# echo -e "\n\033[0;32m The process will finish in the background. \n Check the PDF-folder. It should fill up with pdfs when they are done. \n\n NB: Your computer might become unresponsive for a while. \033[0m"
FAIL=0
for job in $pidlist; do
    # echo $job
    wait $job || let "FAIL+=1"
done

# echo $FAIL

if [ "$FAIL" == "0" ]; then
    echo -e "\n\033[0;32m We are done. Check your PDF folder for your freshly baked chordsheets.\033[0m"
else
    echo "FAIL! ($FAIL)"
    echo -e "\n\033[0;32m We are done. With some errors. Try running chordpro command by itself to list errors.\033[0m"
fi

open ../../PDF/
