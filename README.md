# Dockerfile

個人用Dockerfileレポジトリ

- `./docker_install_memo.md`, `./docker_operation_memo.md`はもう古いの今度更新予定?
- `./make_Dockerfile.sh` は意外と使わなかったので将来削除(Dockerfileの名前を変更して管理した方が早い)
- `./Dockerfiles/pytorch/*` はプラグインが導入されたneovim がインストールされる
- `./Dockerfiles/jupyter/*` はjupyter lab用 ポート番号:8888 を利用する
  - jupyter lab の中でtensorboard が起動可能


### Build example
```bash
docker build ./ --file=./Dockerfile --force-rm=true --no-cache=true -tag=repo:tag
```

### Launch example (nvidia-docker2)
```bash
docker run --runtime=nvidia --rm -it -v /projectDIR:/root/work --name containerName repo:tag
```

