# 使い方

## イメージの作成

一応Dockerfileが存在するが `docker pull` で良いことが判明.

以下を実行すると終了する．

```
docker pull paperist/alpine-texlive-ja
```

ビルドの話はまた今度...



## TeXファイルのコンパイル

対象のtexファイルである `hoge.tex` があるディレクトリに移動し，
以下のコマンドを実行．

```
docker run --rm -v $PWD:/workdir paperist/alpine-texlive-ja uplatex hoge.tex
docker run --rm -v $PWD:/workdir paperist/alpine-texlive-ja dvipdfmx hoge.dvi
```

予め，`.bashrc` 等にエイリアスをしておくと楽．

#### エイリアスの例

以下を`~.bashrc` 等に書き込んでおく．
```
function uplatex()
{
TEX_FILE=$1
FILE_NAME=${TEX_FILE%.*}
command docker run --rm -v $PWD:/workdir paperist/alpine-texlive-ja uplatex ${TEX_FILE}
command docker run --rm -v $PWD:/workdir paperist/alpine-texlive-ja dvipdfmx ${FILE_NAME}.dvi
rm -f ${FILE_NAME}.aux ${FILE_NAME}.fdb_latexmk ${FILE_NAME}.fls ${FILE_NAME}.log
}
```



対象のtexファイルである `hoge.tex` があるディレクトリに移動し，
以下のコマンドを実行．
```
uplatex hoge.tex
```



## よくわかんない話
- epsファイルは上手く変換してくれない
  - 外部の変換ツールを使っているらしい？
