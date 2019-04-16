#!/bin/bash

# ---コマンドの意味 ---
# Docker コンテナを作成後に必要な設定を行うためのインストールファイル
# もし，Jupyter Labが入ってなかったらpip install jupyterlabで入る(Anacondaなら入ってるはず...)

set -e
echo '============================================================'
echo 'Jupyter lab setting'
echo '============================================================'

echo '*** Set Passward ***'
mkdir -p /root/.jupyter
jupyter notebook password


echo 'Generateing  config file...'
TMP_PW=$(cat /root/.jupyter/jupyter_notebook_config.json | egrep --only-matching 'sha1:[0-9a-f]*:[0-9a-f]*')

jupyter notebook --generate-config

APADDR="c.NotebookApp.ip = '*'"
PSWORD="c.NotebookApp.password = u'$TMP_PW'"
BROSER="c.NotebookApp.open_browser = False"
APPORT="c.NotebookApp.port = 8888"

echo $APADDR >> /root/.jupyter/jupyter_notebook_config.py
echo $PSWORD >> /root/.jupyter/jupyter_notebook_config.py
echo $BROSER >> /root/.jupyter/jupyter_notebook_config.py
echo $APPORT >> /root/.jupyter/jupyter_notebook_config.py


echo '*** Install Jupyter lab extensions ***'
echo 'Install Node.js (preprocessing)'
# Node.jsの導入(バージョンは適宜修正してください)
curl -sL https://deb.nodesource.com/setup_11.x | bash -
apt-get install -y --no-install-recommends nodejs

echo 'Install extensions'
# お好きにどうぞ

# 変数名や型、内容を常に横に表示しておける
# デバッグのお供になるかも?
jupyter labextension install @lckr/jupyterlab_variableinspector

# Tensorboard 連携
# TODO エラー吐くけど動くので放置
pip install jupyter-tensorboard
jupyter labextension install jupyterlab_tensorboard
jupyter serverextension enable --py jupyterlab_tensorboard

