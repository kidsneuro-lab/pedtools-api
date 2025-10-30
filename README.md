# Hosting pedtools

[pedtools](https://github.com/magnusdv/pedtools) can be hosted in a docker container and its plotting functions exposed on a `http` endpoint. 
This can be called using `curl`, passing in a `json` payload.

## Example 

### input data
```json
{"id":[1,2,3],"fid":[0,0,1],"mid":[0,0,2],"sex":[1,2,1]}
```

```
# affected
aff=c('girl','fa')
# labels
labs=c(Father='fa',Mother='mo',Daughter='girl'
# other plot attributes
title='Family A'
cex=1.5
```
### output image
![Pedigree Example](./pedigree.png)

## Build the docker image
```shell
docker build -t pedtools .
```

## Run the docker container
```shell
docker run --rm -p 8004:8004 pedtools
```


## Run demo
```sh
./demo.sh
```

## Explanation 
See the [demo.sh](demo.sh) script for the real commands but the idea is:

- Build the ped object
```
curl -s -H "Content-Type: application/json" \
  -d '{"id":[1,2,3],"fid":[0,0,1],"mid":[0,0,2],"sex":[1,2,1]}' \
  http://localhost:8004/ocpu/library/pedtools/R/ped
```

- Render it using the plot ped function
```
curl -s -X POST \
  -d "x=$KEY" \
  http://localhost:8004/ocpu/library/pedtools/R/plot.ped
```

- Download the resulting png
```sh
curl -s -o pedigree.png  http://localhost:8004/ocpu/tmp/$PKEY/graphics/1/png
```

## Other useful endpoints
- http://localhost:8004/ocpu/library/pedtools/info
- http://localhost:8004/ocpu/library/pedtools/R/


## Reference
- https://github.com/magnusdv/pedtools
- https://github.com/opencpu/opencpu-server/tree/master/docker#readme
