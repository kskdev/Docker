# Dockerfile

## Environment chainerv2

| Environment   |  Version  |
|:-------------:|:---------:|
| cuda          | 8.0       |
| cudnn         | v6        |
| python        | 3.6       |

| Library       |  Version  |
|:-------------:|:---------:|
| opencv        | latest    |
| pillow        | latest    |
| scikit-image  | latest    |
| chainer       | 2.0.0     |
| cupy          | 1.0.0.1   |

## Environment anaconda3pytorch

| Environment   |  Version  |
|:-------------:|:---------:|
| cuda          | 9.0       |
| cudnn         | v7        |
| python        | 3.6       |

| Library       |  Version  |
|:-------------:|:---------:|
| opencv3       | latest    |
| pytorch       | latest    |
| torchvision   | latest    |
| visdom        | latest    |
| dominate      | latest    |


## How to build

#### Build Image
`nvidia-docker build -t foo/bar:baz .`
#### Check test
`nvidia-docker run --rm foo/bar:baz nvidia-smi`
#### Run Container
`nvidia-docker run --rm -it -v /data/osumi/:/home/ foo/bar:baz`

