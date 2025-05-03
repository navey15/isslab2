#!/bin/bash

# filters words that start with s but dont have 'a' in them.
filtered_words=$(grep -o '\bs[^a]\w*\b' script.txt | sort | uniq)
#calculate the frequency of each letter in the filtered words
frequencies=$(echo "$filtered_words" | tr -d '[:space:]' | fold -w1 | sort | uniq -c)
# let s be the number that is equal to when we add 97 to the frequency of each letter 
mapped_letters=$(echo "$frequencies" | awk '{print $2, $1+97}')

final_flag=""
for letter in {a..z}; do
  freq=$(echo "$mapped_letters" | grep -w "$letter" | awk '{print $2}')
  if [ -n "$freq" ]; then
    final_flag+=$(printf "\x$(printf %x $freq)")
  else
    final_flag+="a"
  fi
done

# Output the final flag
echo "CTF{$final_flag}" > flag-1.txt
