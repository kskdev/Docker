#!/bin/sh

nvidia-docker build -t osm/chainerV2 .

nvidia-docker run --rm -it -v /data/osumi/:/home/ osm/chainerV2


