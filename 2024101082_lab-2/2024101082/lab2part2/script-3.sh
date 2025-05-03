#!/bin/bash

declare -a freq=($(for i in {1..26}; do echo 0; done))

is_valid_word() {
    word="$1"
    first_char="${word:0:1}"
    last_char="${word: -1}"

    [[ "$first_char" =~ [aeiouAEIOU] ]] && [[ ! "$last_char" =~ [bcdfghjklmnpqrstvwxyzBCDFGHJKLMNPQRSTVWXYZ] ]]
}

to_binary() {
    local num=$1
    local binary=""
    while [ $num -gt 0 ]; do
        binary=$((num % 2))$binary
        num=$((num / 2))
    done
    echo $binary
}

while read -r line; do

    for word in $line; do
       
        if is_valid_word "$word"; then
         
            unique_chars=$(echo "$word" | grep -o . | sort -u | wc -l)

          
            half_length=$((${#word} / 2))
            first_half="${word:0:$half_length}"
            second_half="${word:$half_length}"

           
            y=$(echo "$first_half" | grep -o '[a-lA-L]' | wc -l)

            z=$(echo "$second_half" | grep -o '[n-zN-Z]' | wc -l)

            binary_y=$(to_binary $y)
            binary_z=$(to_binary $z)

            binary_y=$(printf "%08d" $binary_y)
            binary_z=$(printf "%08d" $binary_z)

            binary_string="$binary_y$binary_z"
            decimal_value=$((2#$binary_string))

            freq_index=$((unique_chars - 1))
            if [ "${freq[$freq_index]}" -lt "$decimal_value" ]; then
                freq[$freq_index]=$decimal_value
            fi
        fi
    done
done < script.txt

sum=0
for value in "${freq[@]}"; do
    sum=$((sum + value))
done

# Output the final flag
echo "CTF{$sum}" >>  flag-3.txt