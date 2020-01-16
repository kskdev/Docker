#!/bin/bash

# ---コマンドの意味 ---
# Docker コンテナを作成後に必要な設定を行うためのインストールファイル
# イメージビルド中に作らないのはパスワード設定が絡むため
# もし，Jupyter Labが入ってなかったらpip install jupyterlabで入る(Anacondaなら入ってるはず...)

set -e
echo ''
echo '============================================================'
echo 'Jupyter lab setting'
echo '============================================================'
echo ''

# ホームディレクトリの設定
home_dir=/root

echo ''
echo '*** Set Password ***'
mkdir -p ${home_dir}/.jupyter
jupyter notebook password

jupyter notebook --generate-config
echo ''
echo 'Generated config file.'

TMP_PW=$(cat ${home_dir}/.jupyter/jupyter_notebook_config.json | egrep --only-matching 'sha1:[0-9a-f]*:[0-9a-f]*')
APADDR="c.NotebookApp.ip = '*'"
PSWORD="c.NotebookApp.password = u'$TMP_PW'"
BROSER="c.NotebookApp.open_browser = False"
APPORT="c.NotebookApp.port = 8888"

echo $APADDR >> ${home_dir}/.jupyter/jupyter_notebook_config.py
echo $PSWORD >> ${home_dir}/.jupyter/jupyter_notebook_config.py
echo $BROSER >> ${home_dir}/.jupyter/jupyter_notebook_config.py
echo $APPORT >> ${home_dir}/.jupyter/jupyter_notebook_config.py

echo ''
echo '============================================================'
echo 'Install Jupyter lab extensions'
echo '============================================================'
echo ''
# echo '*** Install Node.js ***'
# Node.jsの導入(バージョンは適宜修正してください)
# curl -sL https://deb.nodesource.com/setup_11.x | bash -
# apt-get install -y --no-install-recommends nodejs

echo '*** Install extensions ***'

# 操作がvimになる.
# jupyter labextension install "jupyterlab_vim" の代替
pip install jupyter_contrib_nbextensions
jupyter contrib nbextension install --user
mkdir -p $(jupyter --data-dir)/nbextensions
cd $(jupyter --data-dir)/nbextensions
git clone https://github.com/lambdalisue/jupyter-vim-binding vim_binding
jupyter nbextension enable vim_binding/vim_binding

# 変数名や型、内容を常に横に表示しておける. デバッグのお供になるかも?
# 動かなくなった (2019/08/26) 恐らくjupyterlab のバージョンを上げたから
# バージョンの違いで入らない (2019/01/15追記)
# jupyter labextension install @lckr/jupyterlab_variableinspector

# Tensorboard 連携
# TODO エラー吐くけど動くので放置
pip install jupyter-tensorboard
jupyter labextension install jupyterlab_tensorboard
# jupyter serverextension enable --py jupyterlab_tensorboard

# plotly用jupyter連携用extension
pip install plotly
# jupyter labextension install "@jupyterlab/plotly-extension"
jupyter labextension install @jupyterlab/plotly-extension

# サイドのタブにmarkdownの見出しとか作ってくれるextension
# .ipynb が長くなってしまった時に簡単にジャンプできるようになる.
# jupyter labextension install "@jupyterlab/toc"
jupyter labextension install @jupyterlab/toc

# 図形を書く
jupyter labextension install jupyterlab-drawio

# csv / json をグラフィカルに表示
# バージョンの違いで入らない (2019/01/15追記)
# jupyter labextension install jupyterlab_voyager

# Notebook の補完がLSPベースになる(補完がさらに強くなる)
# まだ動かなくない...(2019/08/26)
# バージョンの違いで入らない (2019/01/15追記)
# pip install --pre jupyter-lsp
# jupyter labextension install @krassowski/jupyterlab-lsp
# pip install python-language-server[all]
# サーバリストを記述したファイルを生成
# SERVER_YML=${home_dir}/servers.yml
# touch ${SERVER_YML}
# echo "langservers:" >> ${SERVER_YML}
# echo "  python:"    >> ${SERVER_YML}
# echo "    - pyls"   >> ${SERVER_YML}
# node ${home_dir}/Conda/share/jupyter/lab/staging/node_modules/jsonrpc-ws-proxy/dist/server.js --port 3000 --languageServers ${SERVER_YML}


# Jupyter 起動
# 起動したらそのコンテナは放っておけば良い
# 以下のコマンドを実行する (ポート番号(e.g. 8888)は各自でお願いいたします)
echo ''
echo '++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++'
echo 'Finished installing extensions'
echo '++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++'
echo ''
echo 'Please run : jupyter lab --ip=0.0.0.0 --port=8888 --allow-root'
