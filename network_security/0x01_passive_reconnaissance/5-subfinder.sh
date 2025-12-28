#!/bin/bash
subfinder -silent -d $1 | while read h; do ip=$(dig +short $h | head -n 1); [ -n "$ip" ] && echo "$h,$ip"; done | tee $1.txt
