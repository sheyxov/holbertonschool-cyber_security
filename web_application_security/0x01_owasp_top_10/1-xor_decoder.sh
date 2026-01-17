#!/bin/bash
# Decode IBM WebSphere XOR encoded passwords

hash="$1"

clean="${hash#\{xor\}}"

printf "%s" "$clean" | base64 -d | perl -0777 -ne '
@b = unpack("C*", $_);
$k = shift @b;
for (@b) {
    print chr($_ ^ $k);
}
print "\n";
'
