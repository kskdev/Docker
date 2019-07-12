#!/bin/bash

# ---コマンドの意味 ---
# Docker コンテナを作成後に必要な設定を行うためのインストールファイル
# イメージビルド中に作らないのはパスワード設定が絡むため
# もし，Jupyter Labが入ってなかったらpip install jupyterlabで入る(Anacondaなら入ってるはず...)

set -e
echo '============================================================'
echo 'Jupyter lab setting'
echo '============================================================'

# ホームディレクトリの設定
home_dir=/root

echo '*** Set Passward ***'
mkdir -p ${home_dir}/.jupyter
jupyter notebook password

echo 'Generateing  config file...'
jupyter notebook --generate-config

TMP_PW=$(cat ${home_dir}/.jupyter/jupyter_notebook_config.json | egrep --only-matching 'sha1:[0-9a-f]*:[0-9a-f]*')
APADDR="c.NotebookApp.ip = '*'"
PSWORD="c.NotebookApp.password = u'$TMP_PW'"
BROSER="c.NotebookApp.open_browser = False"
APPORT="c.NotebookApp.port = 8888"

echo $APADDR >> ${home_dir}/.jupyter/jupyter_notebook_config.py
echo $PSWORD >> ${home_dir}/.jupyter/jupyter_notebook_config.py
echo $BROSER >> ${home_dir}/.jupyter/jupyter_notebook_config.py
echo $APPORT >> ${home_dir}/.jupyter/jupyter_notebook_config.py

echo '*** Install Jupyter lab extensions ***'
echo 'Install Node.js (preprocessing)'
# Node.jsの導入(バージョンは適宜修正してください)
curl -sL https://deb.nodesource.com/setup_11.x | bash -
apt-get install -y --no-install-recommends nodejs

echo 'Install extensions'

# 変数名や型、内容を常に横に表示しておける. デバッグのお供になるかも?
jupyter labextension install @lckr/jupyterlab_variableinspector

# Tensorboard 連携
# TODO エラー吐くけど動くので放置
pip install jupyter-tensorboard
jupyter labextension install jupyterlab_tensorboard
jupyter serverextension enable --py jupyterlab_tensorboard

# plotly用jupyter連携用extension
pip install plotly
jupyter labextension install @jupyterlab/plotly-extension

# Jupyter 起動
# 起動したらそのコンテナは放っておけば良い
# 以下のコマンドを実行する (ポート番号(e.g. 8888)は各自でお願いいたします)
jupyter lab --ip=0.0.0.0 --port=8888 --allow-root
