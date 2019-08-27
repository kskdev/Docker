# *****************************************************
# Image Build:
#   docker build ./ --file=./Dockerfile --force-rm=true --no-cache=true --rm=true --tag=kosumike/cuda90anaconda3531jupyterlab:v1
# Run Container:
#   docker run --runtime=nvidia --rm -it -v /HostDIR:/root/work --port=8888:8888 --name containerName kosumike/cuda90anaconda3531jupyterlab:v1
# *****************************************************

# =========================================
# Set Versions
# =========================================
FROM nvidia/cuda:9.0-cudnn7-devel-ubuntu16.04

# Work Directory location:
ENV WORK_DIR=/root
WORKDIR $WORK_DIR

# Copy jupyter setup file (run this file in container)
ADD ./set_jupyter_lab.sh $WORK_DIR

# Port forward (6006:TensorboardX, 8888:Jupyter):
EXPOSE 6006 8888 3000

# =========================================
# Install commands
# =========================================
RUN apt-get update && \
apt-get install -y --no-install-recommends \
build-essential \
cmake \
git \
curl \
libjpeg-dev \
libpng-dev \
libgtk2.0-dev \
software-properties-common \
&& \
rm -rf /var/lib/apt/lists/*
# =========================================
# Install Anaconda3
# =========================================
ENV PATH=${WORK_DIR}/Conda/bin:${PATH}
RUN curl --silent -O https://repo.continuum.io/archive/Anaconda3-5.3.1-Linux-x86_64.sh && \
bash Anaconda3-5.3.1-Linux-x86_64.sh -b -p ${WORK_DIR}/Conda && \
conda update --all && \
rm ${WORK_DIR}/Anaconda3-5.3.1-Linux-x86_64.sh
# =========================================
# Install python libs via conda
# =========================================
RUN conda install -c conda-forge \
umap-learn \
opencv=3.4.2 \
nodejs \
neovim=0.3.1 \
python-language-server
# =========================================
# Install Pytorch
# =========================================
RUN conda install -c pytorch \
pytorch=0.4.1 \
torchvision=0.2.1 \
cudatoolkit=9.0
# =========================================
# Install python libs via pip
# =========================================
RUN pip install \
tensorflow \
tensorboardX==1.4 \
bhtsne
# =========================================
# Install neovim with plugins
# =========================================
RUN add-apt-repository ppa:neovim-ppa/unstable && \
apt-get update && \
apt-get install neovim -y --no-install-recommends && \
# --- Install plugin for Neovim --- 
git clone https://github.com/kskdev/vim && \
mkdir -p $WORK_DIR/.config/nvim && \
cp vim/dein.toml $WORK_DIR/.config/nvim/ && \
cp vim/vimrc $WORK_DIR/.config/nvim/init.vim && \
nvim -e -c ":silent! call dein#install() | :q" && \
nvim -e -c ":silent! UpdateRemotePlugins | :q"
# =========================================
# Add Alias Commands
# =========================================
RUN /bin/bash && \
apt-get clean && \
apt-get autoremove && \
echo "set completion-ignore-case on" > $WORK_DIR/.inputrc && \
echo "alias c='clear'" >> $WORK_DIR/.bashrc && \
echo "alias use='du -d 1 -h'" >>$WORK_DIR/.bashrc && \
echo "alias vi='nvim'" >> $WORK_DIR/.bashrc && \
echo "Please run 'set_jupyter_lab.sh' in container."

