#!/usr/bin/env bash
echo "Starting pedtools demo"

echo "-----------------------------------------------------"
echo "Creating pedigree object."
RESULT1=$(curl -s -H "Content-Type: application/json" \
  -d '{"id":["fa","mo","girl"],"fid":["","","fa"],"mid":["","","mo"],"sex":[1,2,2]}' \
  http://localhost:8004/ocpu/library/pedtools/R/ped)
echo "$RESULT1"

echo "-----------------------------------------------------"
echo "Fetching session key 1..."
SESSION1=$(echo "$RESULT1" | awk -F'/tmp/' '/tmp/{print $2}' | cut -d'/' -f1 | head -n1)
echo "Session: $SESSION1"

echo "-----------------------------------------------------"
echo "Fetching console output:"
curl "http://localhost:8004/ocpu/tmp/${SESSION1}/stdout/text"

echo "-----------------------------------------------------"
echo "Generating pedigree plot with father and girl affected..."
RESULT2=$(curl -s -X POST \
  --data-urlencode "x=$SESSION1" \
  --data-urlencode "aff=c('girl','fa')" \
  --data-urlencode "labs=c(Father='fa',Mother='mo',Daughter='girl')" \
  --data-urlencode "cex=1.5" \
  --data-urlencode "title='Family A'" \
  http://localhost:8004/ocpu/library/pedtools/R/plot.ped)
echo "$RESULT2"
  
echo "-----------------------------------------------------"
echo "Fetching session key 2..."
SESSION2=$(echo "$RESULT2" | awk -F'/tmp/' '/tmp/{print $2}' | cut -d'/' -f1 | head -n1)
echo "Session 2: $SESSION2"

echo "-----------------------------------------------------"
echo "Downloading pedigree plot image to pedigree.png"
curl -s -o pedigree.png  http://localhost:8004/ocpu/tmp/$SESSION2/graphics/1/png
echo "Image saved to pedigree.png"

