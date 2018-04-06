#!/bin/sh

git clone https://github.com/kskdev/Docker

nvidia-docker build -t username/tag .

nvidia-docker run --rm -it -v /foo/bar/:/home/ username/tag


