#!/bin/bash

#DISREGARD ALL THE OTHER TEMPORARY FILES CREATED.

touch palindromes.txt middle_letters.txt temp_flag.txt
grep -o '\<\w\+\>' script.txt | while read word; do
    word_lower=$(echo "$word" | tr '[:upper:]' '[:lower:]')
    if [ "$word_lower" = "$(echo "$word_lower" | rev)" ]; then
        echo "$word"
    fi
done | sort -u > palindromes.txt
while read -r word; do
    len=${#word}
    if [ $((len % 2)) -eq 1 ]; then
        mid=$((len / 2))
        echo -n "${word:$mid:1}" >> middle_letters.txt
    fi
done < palindromes.txt
middle_word=$(cat middle_letters.txt)
middle_word_rev=$(echo "$middle_word" | rev)
if [ "$middle_word" = "$middle_word_rev" ]; then
    while read -r word; do
        len=${#word}
        if [ $((len % 2)) -eq 0 ]; then
            echo -n "$word" >> temp_flag.txt
        fi
    done < palindromes.txt
else
    while read -r word; do
        len=${#word}
        if [ $((len % 2)) -eq 0 ]; then
            half=$((len / 2))
            echo -n "${word:0:$half}" >> temp_flag.txt
        fi
    done < palindromes.txt
fi
echo "CTF{$(cat temp_flag.txt)}" > flag-2.txt
rm -f middle_letters.txt temp_flag.txt palindromes.txt