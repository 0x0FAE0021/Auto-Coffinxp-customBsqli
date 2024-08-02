#!/bin/bash

if [ -z "$1" ]; then
  echo "Uso: $0 <SITE_URL>"
  exit 1
fi

SITE_URL=$1

CLEAN_URL=$(echo $SITE_URL | sed -e 's|^http://||' -e 's|^https://||' -e 's|/$||')

paramspider -d $CLEAN_URL

mv results/$CLEAN_URL.txt .

rm -r results

cat $CLEAN_URL.txt | sed 's/FUZZ//g' > final.txt

python3 lostsec.py -l final.txt -p payloads/xor.txt -t 5