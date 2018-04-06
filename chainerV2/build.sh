#!/bin/sh

nvidia-docker build -t osm/chainer:v2 .

nvidia-docker run --rm -it -v /data/osumi/:/home/ osm/chainer:v2


