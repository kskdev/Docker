# Dockerfile

## Environment

| Environment   |  Version  |
|:-------------:|:---------:|
| cuda          | 8.0       |
| cudnn         | v6        |
| python        | 3.6       |

## Libraries by pip

| Library       |  Version  |
|:-------------:|:---------:|
| opencv        | latest    |
| pillow        | latest    |
| scikit-image  | latest    |
| chainer       | 2.0.0     |
| cupy          | 1.0.0.1   |


## How to build

#### Build Image
`nvidia-docker build -t osm:chainer:v2 .`
#### Check test
`nvidia-docker run --rm osm:osumi:v2 nvidia-smi`
#### Run Container
`nvidia-docker run --rm -it -v /data/osumi/:/home/ osm:osumi:v2`

