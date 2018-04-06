# Dockerインストールメモ(特にNvidia-Docker)
実行した時の環境はUbuntu 14.04LTS  
そのためUbuntu14.04LTS以外での保証はしない.


## インストール

#### サーバーからパッケージ・リストを入手する  
`sudo apt-get update`

#### インストールに必要な各種パッケージをインストール  
`sudo apt-get install apt-transport-https ca-certificates curl software-properties-common`

#### GPG鍵の取得  
`curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -`

#### source.listの更新
###### Ubuntu 14.04の場合
`echo "deb https://apt.dockerproject.org/repo ubuntu-trusty main" | sudo tee /etc/apt/sources.list.d/docker.list`
###### Ubuntu 16.04の場合
`echo "deb https://apt.dockerproject.org/repo ubuntu-xenial main" | sudo tee /etc/apt/sources.list.d/docker.list`  
もしUbuntuのバージョンがわからなければ`cat /etc/os-release`で確認する.

#### 依存パッケージのインストール
`sudo apt-get update`  
`sudo apt-get install linux-image-extra-$(uname -r) linux-image-extra-virtual`

#### 最新版のDockerをインストール
`curl -fsSL https://get.docker.com/ | sh`


#### Dockerグループへの追加
一般ユーザで実行するための処理を行う.
*ユーザ名はログイン中のユーザ名に変更する*  
`sudo gpasswd -a ユーザー名 docker`

#### Dockerデーモンを起動
`sudo service docker start`

#### Dockerがインストールされたか確認
`docker run hello-world`  
しかし上記を実行すると，  
`docker: Got permission denied while trying to connect to the Docker daemon socket at unix:///var/run/docker.sock: Post http://%2Fvar%2Frun%2Fdocker.sock/v1.33/containers/create: dial unix /var/run/docker.sock: connect: permission denied.
See 'docker run --help'.`  
のようなエラーが起こる．これを解消するには *一旦ログアウト* する．  
ログイン後，再度`docker run hello-world`を実行すると,  
`Hello from Docker!  
This message shows that your installation appears to be working correctly.以下略
`
が表示され， *"Docker"* のインストールはとりあえず終了．

## Nvidia-Dockerのインストール
[公式Nvidia-Docker github](https://github.com/NVIDIA/nvidia-docker)に従って進める.  
OSのディストリがUbuntuのため以下を実行する.  
`wget -P /tmp https://github.com/NVIDIA/nvidia-docker/releases/download/v1.0.1/nvidia-docker_1.0.1-1_amd64.deb`  
`sudo dpkg -i /tmp/nvidia-docker*.deb && rm /tmp/nvidia-docker*.deb`  

インストールが正しく出来たかを確認するために, nvidia-smi を実行.(色々追加されるので, しばらく待つ)
`nvidia-docker run --rm nvidia/cuda nvidia-smi`  

もし， *unsupported CUDA version:foobar* のようなエラーが発生した場合，`nvcc -V`コマンドでCUDAのバージョンを調べる．  
例として，CUDAのバージョンが8.0(さらにcudnn v6導入済み)だった場合，以下のように実行する．  
`nvidia-docker run --rm nvidia/cuda:8.0-cudnn6-devel nvidia-smi`　　

NVIDIA-SMIが表示され，無事インストール完了.  

参考:  
・[Docker Engine Utility for NVIDIA GPUs](https://github.com/NVIDIA/nvidia-docker)  
・[一般ユーザで docker コマンド](http://labory.sakuraweb.com/blog/2017/07/06/%E4%B8%80%E8%88%AC%E3%83%A6%E3%83%BC%E3%82%B6%E3%81%A7-docker-%E3%82%B3%E3%83%9E%E3%83%B3%E3%83%89/)  
・[Error: unsupported CUDA version: driver 8.0 < image 9.0.176](https://github.com/NVIDIA/nvidia-docker/issues/497)





## アンインストール
 インストールしたDockerのサービスやイメージファイル等を削除する.  
 削除には`apt-get purge`を利用してDockerをアンインストールする.
 `$ sudo apt-get purge docker-ce`

 これだけではDockerが利用するイメージ等がディスクに残っている状態ままである.
 `$ sudo rm -rf /var/lib/docker`

 上記を実行すればデフォルトのディレクトリである /var/lib/docker を削除する.  
 とりあえずこれで駆除は完了するらしい...?
