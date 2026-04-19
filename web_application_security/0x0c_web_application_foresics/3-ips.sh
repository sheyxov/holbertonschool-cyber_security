#!/bin/bash

grep "Accepted password" auth.log | \
awk '{print $NF}' | \
sort | \
uniq | \
wc -l
