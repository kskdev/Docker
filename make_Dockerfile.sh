#!/bin/bash

# osmksk05 専用のDockerfile Generator
# 何故専用なのかはvim8のプラグインが自分用のだから
# ---コマンドの意味 ---
# echo -n "hoge"   ：hogeを表示した後改行しない
# echo -e "\nhoge" ：\nを改行コードとして認識する

set -e
echo '============================================================'
echo 'Dockerfile Generator'
echo '============================================================'


echo ''
echo '--- Select base image ---'

echo -n 'CUDA ver (8.0 or 9.0 or 10.0): ' && read CUDA
while ! [ $(echo ${CUDA} | grep -E '^(8\.0|9\.0|10\.0)$') ]
do
    echo -n 'please input again : ' && read CUDA
done


echo -n 'CuDNN ver (6 or 7): ' && read CUDNN
while ! [ $(echo ${CUDNN} | grep -E '^(6|7)$') ]
do
    echo -n 'please input again : ' && read CUDNN
done


echo -n 'Ubuntu ver (16.04 or 18.04): ' && read UBUNTU
while ! [ $(echo ${UBUNTU} | grep -E '^(16\.04|18\.04)$') ]
do
    echo -n 'please input again : ' && read UBUNTU
done



echo ''
echo '--- Select Conda Environment ---'

echo -n 'Python ver (2 or 3): ' && read CONDA_PY_VER
while ! [ $(echo ${CONDA_PY_VER} | grep -E '^(2|3)$') ]
do
    echo -n 'please input again : ' && read CONDA_PY_VER
done


echo -n 'Conda Distribution (Anaconda or Miniconda): ' && read CONDA_DIS
while ! [ $(echo ${CONDA_DIS} | grep -E '^(Anaconda|Miniconda)$') ]
do
    echo -n 'please input again : ' && read CONDA_DIS
done

echo 'Ref : https://repo.continuum.io/{archive|miniconda}/ (e.g. 5.3.1 , 4.5.1)'
echo -n 'Conda ver : ' && read CONDA_VER
while ! [ $(echo ${CONDA_VER} | grep -E '^([0-9]*\.[0-9]*\.[0-9]*)$') ]
do
    echo -n 'please input again : ' && read CONDA_VER
done

if [ ${CONDA_DIS} = 'Anaconda' ]; then
CONDA_URL=https://repo.continuum.io/archive/${CONDA_DIS}${CONDA_PY_VER}-${CONDA_VER}-Linux-x86_64.sh
else
CONDA_URL=https://repo.continuum.io/miniconda/${CONDA_DIS}${CONDA_PY_VER}-${CONDA_VER}-Linux-x86_64.sh
fi



echo ''
echo '--- Select Deep Learning Library ---'

echo -n 'Deep Learning (pytorch or chainer): ' && read DL_LIBRARY
while ! [ $(echo ${DL_LIBRARY} | grep -E '^(pytorch|chainer)$') ]
do
    echo -n 'please input again : ' && read DL_LIBRARY
done


if [ ${DL_LIBRARY} = 'pytorch' ]; then
	echo -n 'pytorch ver (0.4.1 or 1.0.0): ' && read PYTORCH
    while ! [ $(echo ${PYTORCH} | grep -E '^(0\.4\.1|1\.0\.0)$') ]
    do
        echo -n 'please input again : ' && read PYTORCH
    done

	echo -n 'torchvision ver (0.2.0 or 0.2.1): ' && read TORCHVISION
    while ! [ $(echo ${TORCHVISION} | grep -E '^(0\.2\.0|0\.2\.1)$') ]
    do
        echo -n 'please input again : ' && read TORCHVISION
    done

    CUDATOOLKIT=${CUDA}


elif [ ${DL_LIBRARY} = 'chainer' ]; then
	echo -n 'chainer ver : ' && read CHAINER
    while ! [ $(echo ${CHAINER} | grep -E '^([0-9]*\.[0-9]*\.[0-9]*)$') ]
    do
        echo -n 'please input again : ' && read CHAINER
    done

    CUPY=cupy-cuda${CUDA/./}

else
	:
fi




echo \
"# *****************************************************
# This Dockerfile was generated by 'make_Dockerfile.sh'.
# Image Build:
#   docker build ./ --force-rm=true --no-cache=true --tag=repo:tag
# Run Container:
#   docker run --runtime=nvidia --rm -it -v /HostDIR:/root/work --name containerName repo:tag
# *****************************************************

# =========================================
# Set Versions
# =========================================
FROM nvidia/cuda:${CUDA}-cudnn${CUDNN}-devel-ubuntu${UBUNTU}

# Work Directory location:
ENV WORK_DIR=/root
WORKDIR \$WORK_DIR

# Port forward (6006:TensorboardX, 8888:Jupyter):
EXPOSE 6006 8888


# =========================================
# Install commands
# =========================================
RUN apt-get update && \\
apt-get install -y --no-install-recommends \\
build-essential \\
cmake \\
git \\
curl \\
libjpeg-dev \\
libpng-dev \\
software-properties-common \\
&& \\
rm -rf /var/lib/apt/lists/* && \\" > 'Dockerfile'


echo \
"# =========================================
# Install Vim8 with Plugins for kskdev
# =========================================
add-apt-repository ppa:jonathonf/vim && \\
apt-get update && \\
apt-get install -y vim && \\
# Install Vim with my plugins (Only Vim8)
git clone https://github.com/kskdev/vim && \\
mkdir \$WORK_DIR/.vim && \\
cp vim/*.toml \$WORK_DIR/.vim/ && \\
mv vim/vimrc \$WORK_DIR/.vimrc && \\
rm -rf vim" >> 'Dockerfile'


echo \
"# =========================================
# Install Conda
# =========================================
ENV PATH=\${WORK_DIR}/Conda/bin:\${PATH}
RUN curl --silent -O ${CONDA_URL} && \\
bash ${CONDA_DIS}${CONDA_PY_VER}-${CONDA_VER}-Linux-x86_64.sh -b -p \${WORK_DIR}/Conda && \\
rm \${WORK_DIR}/${CONDA_DIS}${CONDA_PY_VER}-${CONDA_VER}-Linux-x86_64.sh && \\" >> 'Dockerfile'


echo \
"# =========================================
# Install Python Library
# =========================================
conda install -c menpo opencv3 && \\
conda install -c conda-forge \\
numpy \\
matplotlib \\
pillow \\
&& \\" >> 'Dockerfile'


if [ ${DL_LIBRARY} = 'pytorch' ]; then
echo \
"# =========================================
# Install Pytorch 
# =========================================
conda install -c pytorch \\
pytorch=${PYTORCH} \\
torchvision=${TORCHVISION} \\
cudatoolkit=${CUDATOOLKIT} \\
&& \\" >> 'Dockerfile'

elif [ ${DL_LIBRARY} = 'chainer' ]; then
echo \
"# =========================================
# Install Chainer
# =========================================
pip install \\
chainer==${CHAINER} \\
${CUPY} \\
&& \\" >> 'Dockerfile'

else
	:
fi


echo \
"# =========================================
# Additional Library
# =========================================
pip install \\
tensorflow \\
tensorboardX \\
&& \\" >> 'Dockerfile'


echo \
"# =========================================
# Add Alias Commands
# =========================================
/bin/bash && \\
apt-get clean && \\
apt-get autoremove && \\
echo \"set completion-ignore-case on\" > \$WORK_DIR/.inputrc && \\
echo \"alias c='clear'\" >> \$WORK_DIR/.bashrc && \\
echo \"alias use='du -d 1 -h'\" >>\$WORK_DIR/.bashrc && \\
echo \"alias vi='vim'\" >> \$WORK_DIR/.bashrc" >> 'Dockerfile'

echo ''
echo 'Created Dockerfile!!'
echo 'Check Dockerfile!'