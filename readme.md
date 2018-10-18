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

## Environment anaconda3　4.4.0

| Environment   |  Version  |
|:-------------:|:---------:|
| cuda          | 9.0       |
| cudnn         | v7        |
| python        | 3.6       |

| Library       |  Version  |
|:-------------:|:---------:|
| opencv3       | latest    |
| pytorch       | 0.4.0     |
| torchvision   | 0.2.1     |
| visdom        | latest    |
| dominate      | latest    |
| cupy-cuda90   | 4.4.1     |
| chainer       | 4.3.1     |


## How to build

#### Build Image
`nvidia-docker build -t repoName:TagName .`
#### Check test
`nvidia-docker run --rm repoName:TagName nvidia-smi`
#### Run Container
`nvidia-docker run --rm -it --name コンテナに付ける名前 -v お好きなホストDIR:接続したいコンテナのDIR repoName:TagName`

