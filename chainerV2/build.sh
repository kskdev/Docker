#!/bin/sh

git clone https://github.com/kskdev/vim

nvidia-docker build -t osmksk05/wilshere:v12 .

nvidia-docker run --rm -it -v /data/osumi/:/home/ osmksk05/wilshere:v12


