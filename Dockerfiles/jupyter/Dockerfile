# *****************************************************
# Image Build:
#   docker build ./ --file=./Dockerfile --force-rm=true --no-cache=true --rm=true --tag=anaconda3531:jupyterlab
# Run Container:
#   docker run --runtime=nvidia --rm -it -v /HostDIR:/root/work --port=8888:8888 --name containerName anaconda3531:jupyterlab
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
EXPOSE 6006 8888


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
# Install Conda
# =========================================
ENV PATH=${WORK_DIR}/Conda/bin:${PATH}
RUN curl --silent -O https://repo.continuum.io/archive/Anaconda3-5.3.1-Linux-x86_64.sh && \
bash Anaconda3-5.3.1-Linux-x86_64.sh -b -p ${WORK_DIR}/Conda && \
rm ${WORK_DIR}/Anaconda3-5.3.1-Linux-x86_64.sh && \
# =========================================
# Install Python Library
# =========================================
conda install -c menpo opencv3 \
&& \
# =========================================
# Install Pytorch 
# =========================================
conda install -c pytorch \
pytorch=0.4.1 \
torchvision=0.2.1 \
cudatoolkit=9.0 \
&& \
# =========================================
# Additional Library (for visualization) 
# =========================================
pip install \
tensorflow \
tensorboardX==1.4 \
bhtsne \
&& \
conda install -c conda-forge umap-learn
# =========================================
# Install neovim with Plugins for kskdev
# =========================================
RUN add-apt-repository ppa:neovim-ppa/unstable && \
apt-get update && \
apt-get install -y neovim && \
pip install neovim && \
# Install neovim with my plugins (for neovim) 
git clone https://github.com/kskdev/vim && \
mkdir -p $WORK_DIR/.config/nvim/ && \
cp vim/dein.toml $WORK_DIR/.config/nvim/ && \
cp vim/vimrc $WORK_DIR/.config/nvim/init.vim && \
/bin/bash -c 'nvim -e -c ":silent! call dein#install() | :q"' && \
/bin/bash -c 'nvim -e -c ":UpdateRemotePlugin | :q"' && \
rm -rf vim
# =========================================
# Add Alias Commands
# =========================================
RUN /bin/bash && \
apt-get clean && \
apt-get autoremove && \
echo "set completion-ignore-case on" > $WORK_DIR/.inputrc && \
echo "alias c='clear'" >> $WORK_DIR/.bashrc && \
echo "alias use='du -d 1 -h'" >>$WORK_DIR/.bashrc && \
echo "alias vi='nvim'" >> $WORK_DIR/.bashrc
