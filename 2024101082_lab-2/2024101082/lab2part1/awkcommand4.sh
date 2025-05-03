awk -F',' '{
    sum1 += $1; 
    sum2 += $2; 
    sum3 += $3; 
    count++
} 
END {
    avg1 = sum1 / count;
    avg2 = sum2 / count;
    avg3 = sum3 / count;
    max_avg = (avg1 > avg2 ? avg1 : avg2);
    max_avg = (max_avg > avg3 ? max_avg : avg3);
    print max_avg;
}' data.csv > awk-output-4.txt