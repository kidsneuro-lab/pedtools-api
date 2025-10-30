#!/usr/bin/env bash
echo "Starting pedtools demo"

echo "-----------------------------------------------------"
echo "Creating pedigree object."
RESULT_PED=$(curl -s -H "Content-Type: application/json" \
  -d '{"id":["fa","mo","girl"],"fid":["","","fa"],"mid":["","","mo"],"sex":[1,2,2]}' \
  http://localhost:8004/ocpu/library/pedtools/R/ped)
echo "$RESULT_PED"

echo "-----------------------------------------------------"
echo "Fetching session key 1..."
SESSION_PED=$(echo "$RESULT_PED" | awk -F'/tmp/' '/tmp/{print $2}' | cut -d'/' -f1 | head -n1)
echo "Session: $SESSION_PED"

echo "-----------------------------------------------------"
echo "Fetching console output:"
curl "http://localhost:8004/ocpu/tmp/${SESSION_PED}/stdout/text"

echo "-----------------------------------------------------"
echo "Generating pedigree plot with father and girl affected..."
RESULT_PLOT=$(curl -s -X POST \
  --data-urlencode "x=$SESSION_PED" \
  --data-urlencode "aff=c('girl','fa')" \
  --data-urlencode "labs=c(Father='fa',Mother='mo',Daughter='girl')" \
  --data-urlencode "cex=1.5" \
  --data-urlencode "title='Family A'" \
  http://localhost:8004/ocpu/library/pedtools/R/plot.ped)
echo "$RESULT_PLOT"
  
echo "-----------------------------------------------------"
echo "Fetching session key 2..."
SESSION_PLOT=$(echo "$RESULT_PLOT" | awk -F'/tmp/' '/tmp/{print $2}' | cut -d'/' -f1 | head -n1)
echo "Session 2: $SESSION_PLOT"

echo "-----------------------------------------------------"
echo "Downloading pedigree plot image to pedigree.png"
curl -s -o pedigree.png "http://localhost:8004/ocpu/tmp/${SESSION_PLOT}/graphics/1/png"
echo "Image saved to pedigree.png"

