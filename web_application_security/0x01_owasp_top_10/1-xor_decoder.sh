#!/bin/bash
#
# Decode WebSphere XOR encoded strings
# Usage: ./1-xor_decoder.sh {xor}ENCODED
#

encoded="$1"
xor_key=95

# Remove {xor} prefix
cleaned=$(echo "$encoded" | sed 's/^{xor}//')

# Base64 decode
decoded=$(echo "$cleaned" | base64 -d 2>/dev/null)

# XOR decode
result=""
i=0

while [ $i -lt ${#decoded} ]
do
	char=$(printf '%d' "'${decoded:$i:1}")
	xored=$((char ^ xor_key))
	result="$result$(printf \\$(printf '%03o' "$xored"))"
	i=$((i + 1))
done

echo "$result"
