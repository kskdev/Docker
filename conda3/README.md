# Build Guide
イメージのビルドとコンテナの作成方法を簡単に説明(ほぼ備忘録)

## Docker Imageのビルド
`
nvidia-docker build --rm --no-cache -t conda3:440 .
`

### 説明
- ` nvidia-docker build `
 - Dockerfile から Image をビルド
- ` --rm `
 - イメージ作成後中間イメージを削除する(要は完成まで作った中途半端なファイルは削除)
- ` --no-cache `
 - 文字列の通りキャッシュを使わずにビルド
- ` -t `
 - ビルド後にイメージのリポジトリ名とタグ名を付与．ここでは conda3:440 と命名(RepoName:TagName)
- ` . `
 - ビルドに使うDockerfileのディレクトリ


## Docker Container の作成
`
nvidia-docker run --rm -it -v /home/osumi:/home/osumi -v /data/osumi:/data/osumi --name kskdevConda3  conda3:440
`

### 説明
- ` nvidia-docker run `
 - コンテナの作成．この後ろに大抵色んなオプションが付与される
- ` --rm `
 - コンテナの終了時，そのコンテナを破棄する
- ` -it `
 - コンテナ内部で操作できるようにする
- ` -v `
 - 指定したディレクトリをホストと共有する．複数指定も可能
- ` --name `
 - コンテナに名前を付ける．
- ` conda3:440 `
 - 作成するコンテナのImageを指定



