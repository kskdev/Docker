# Dockerfile

りーどみーがぐだってるのでどうにかする(やる気でない)

## Build Image
`docker build ./ --force-rm=true --no-cache=true -t repo:tag .`

## Run Container
`docker run --runtime=nvidia --rm -it -v /projectDIR:/root/work --name containerName repo:tag`

