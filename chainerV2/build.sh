#!/bin/sh

nvidia-docker build -t osm/chainerv2 .

nvidia-docker run --rm -it -v /data/osumi/:/home/ osm/chainerv2


