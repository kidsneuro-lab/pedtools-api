#!/usr/bin/env bash
echo "Starting pedtools demo"

CREATE=$(curl -s -H "Content-Type: application/json" \
  -d '{"id":[1,2,3],"fid":[0,0,1],"mid":[0,0,2],"sex":[1,2,1]}' \
  http://localhost:8004/ocpu/library/pedtools/R/ped)
echo "$CREATE"
echo "Created pedigree object."

echo "Fetching session key..."
KEY=$(echo "$CREATE" | awk -F'/tmp/' '/tmp/{print $2}' | cut -d'/' -f1 | head -n1)
echo "Session: $KEY"

echo "Fetching console output:"
curl http://localhost:8004/ocpu/tmp/$KEY/stdout/text
echo ""

echo "Generating pedigree plot..."
PLOT=$(curl -s -X POST \
  -d "x=$KEY&labs=TRUE" \
  http://localhost:8004/ocpu/library/pedtools/R/plot.ped)
  
echo "$PLOT"
# returns a NEW session key that contains /graphics/1/png
PKEY=$(echo "$PLOT" | awk -F'/tmp/' '/tmp/{print $2}' | cut -d'/' -f1 | head -n1)
curl -s -o pedigree.png  http://localhost:8004/ocpu/tmp/$PKEY/graphics/1/png

echo "Pedigree plot saved as pedigree.png"
