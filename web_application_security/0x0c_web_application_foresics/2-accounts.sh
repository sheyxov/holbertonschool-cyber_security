#!/bin/bash

tail -n 1000 $1 | \
grep "Failed password\|Accepted password" | \
awk '{
    for(i=1;i<=NF;i++){
        if($i=="for"){
            if($(i+1)=="invalid"){
                print $(i+3)
            } else {
                print $(i+1)
            }
        }
    }
}' | \
sort | \
uniq -c | \
sort -nr | \
head -n 1 | \
awk '{print $2}'
