#!/bin/sh

nvidia-docker build -t osm/anaconda3pytorch:latest .

nvidia-docker run --rm -it -v /data/osumi/:/home/ osm/anaconda3pytorch:latest


