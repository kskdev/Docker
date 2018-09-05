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
| pytorch       | 0.4.0     |
| torchvision   | 0.2.0     |
| visdom        | latest    |
| dominate      | latest    |
| cupy          | 4.2.0     |
| chainer       | 4.2.0     |


## How to build

#### Build Image
`nvidia-docker build -t repoName:TagName .`
#### Check test
`nvidia-docker run --rm repoName:TagName nvidia-smi`
#### Run Container
`nvidia-docker run --rm -it --name $B%3%s%F%J$KIU$1$kL>A0(B -v $B$*9%$-$J%[%9%H(BDIR:$B@\B3$7$?$$%3%s%F%J$N(BDIR repoName:TagName`

