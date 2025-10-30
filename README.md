# Hosting pedtools

[pedtools](https://github.com/magnusdv/pedtools) can be hosted in a docker container and its plotting functions exposed on a `http` endpoint. 
This can be called using `curl`, passing in a `json` payload.

## Example 

### input data
```json
{"id":[1,2,3],"fid":[0,0,1],"mid":[0,0,2],"sex":[1,2,1]}
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

## Reference
- https://github.com/magnusdv/pedtools
- https://github.com/opencpu/opencpu-server/tree/master/docker#readme
