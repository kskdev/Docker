# Dockerfile

りーどみーがぐだってるのでどうにかする(やる気でない)

今まで色んなバージョンのDockerfileを置いておいたが管理がダルいのでGeneratrorでその都度生成することにした．

uplatex は取り敢えず残してあるだけで別にいらないかも...

### Build Image
```bash
docker build ./ --force-rm=true --no-cache=true -t repo:tag
```

### Run Container
```bash
docker run --runtime=nvidia --rm -it -v /projectDIR:/root/work --name containerName repo:tag
```

## Dockerfile Generator

Dockerfileの管理もめんどくさいのでDeep Learning用にDockerfileを作成するジェネレータを作った．

使用言語はBash(Shell Script)．

WindowsならWSL（Windows Subsystem for Linux）とかBashが使えれば生成出来ると思う．

Pythonのバージョンが違うと動作が怪しいかもしれないので注意．

Python は2or3 を選んでAnaconda か Miniconda で入れる．

Deep Learning用ライブラリはpytorch or chainer で入れる．(私がそれしか使ってないため)

将来的にPythonモジュールをこの make_Dockerfile.sh から追加出来るようにする．(気が向かないのでまた今度)

docker build や docker run の方法はDockerfileの最初の行に例を書いた．

nvidia-docker v1 なら run の方法は nvidia-docker run 〜〜 <br>
nvidia-docker v2 なら run の方法は docker run --runtime=nvidia 〜〜



### How to use
```bash
bash make_Dockerfile.sh
```

メッセージが出てくるのでそれに従うだけで終わる．

曖昧補間とかまでは対応してないため，正しい文字列を打つ必要がある．



例えば，

```
Conda Distribution (Anaconda or Miniconda): 
```

と表示された場合， `Anaconda`または`Miniconda`のどちらかを正しく打つ必要がある．

Anaconda 及び Minicondaのバージョン指定方法は， 1.2.3みたいな感じで入力する．

入力するべきバージョンはサイトに記載されているのでそれに従う．



まだ使い方がだるいので対応は追々する．

ベタベタに書いただけ．



## Others

ライブラリとそのバージョンを指定するだけで出来るみたいな?ものを目指したかった...