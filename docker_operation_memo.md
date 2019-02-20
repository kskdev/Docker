# Dockerの操作メモ(特にNvidia-Docker)
実行した時の環境はUbuntu 14.04LTS
そのためUbuntu14.04LTS以外での保証はしない.

ちょっと情報が古いかもしれないので更新版を載せる予定？？
いずれ新しい方で統一すると思われる．
(別に古くても動くと思う...)

## 基本操作

#### Docker imageの一覧表示
old: `docker images`
new: `docker image ls`
new: `docker image ls -a`


#### コンテナの表示
old: 動作中のコンテナ: `docker ps`
old: すべてのコンテナ: `docker ps -a`
new: 動作中のコンテナ: `docker container ls`
new: すべてのコンテナ: `docker container ls -a`

#### ホストのディレクトリをマウントしてコンテナ起動
`nvidia-docker run -it -v [ホストディレクトリの絶対パス]:[コンテナの絶対パス] [イメージ名] [コマンド]`
例:`nvidia-docker run --rm -it -v /home/user/:/root/ myenv:username`


#### 既存コンテナの起動
`nvidia-docker start コンテナID`

#### コンテナに入る
`nvida-docker attach コンテナID`

#### コンテナから脱出(作業が途切れない)
`Ctrl + P →  Ctrl + Q`

#### コンテナの終了(コンテナごと終了するため作業も停止)
`exit`


#### コンテナイメージの取得
`docker pull [イメージ名]:[タグ]`


#### Dockerfileからimageをビルド
`nvidia-docker build -t [ユーザ名]/[イメージの名前]:[バージョン] .`


#### タグ付け(ただし，REPOSITORYとTAGがnoneになっている場合のみ)
ImageID, REPOSITORY, TAGは `docker images`から確認.
`docker tag imageID REPOSITORY:TAG`



#### コンテナの削除
`docker rm [イメージID]`


#### none イメージの一括削除
`docker rmi $(docker images -f "dangling=true" -q)`

###### *停止中のコンテナの全削除*
`docker rm "docker ps -a -q"`


#### コンテナ *"イメージ"* の削除
`docker rmi`

#### none イメージの一括削除
`docker rmi $(docker images -f "dangling=true" -q)`



