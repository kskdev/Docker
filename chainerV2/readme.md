# Dockerfile

## Environment

| Environment   |  Version  |
|:-------------:|:---------:|
| cuda          | 8.0       |
| cudnn         | v6        |
| python        | 3.5       |
| opencv        | latest    |

## Libraries by pip

| Library       |  Version  |
|:-------------:|:---------:|
| chainer       | 2.0.0     |
| bhtsne        | 0.1.9     |

## How to build

#### Build Image
`nvidia-docker build -t osm:chainer:v2 .`
#### Check test
`nvidia-docker run --rm osm:osumi:v2 nvidia-smi`
#### Run Container
`nvidia-docker run --rm -it -v /data/osumi/:/home/ osm:osumi:v2`

