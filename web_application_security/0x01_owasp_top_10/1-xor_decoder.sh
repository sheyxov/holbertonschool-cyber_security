#!/bin/bash
# Decode IBM WebSphere XOR encoded strings

hash="$1"

clean_hash="${hash#\{xor\}}"

decoded="$(printf "%s" "$clean_hash" | base64 -d)"

key="$(printf "%s" "$decoded" | od -An -t u1 | awk 'NR==1 { print $1 }')"

printf "%s" "$decoded" \
| od -An -t u1 \
| awk '
NR==1 { next }
{
    for (i = 1; i <= NF; i++)
    {
        printf "%c", ($i ^ key)
    }
}
'
printf "\n"
