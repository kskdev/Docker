# https://github.com/qntfy/nvidia-docker-anaconda
FROM nvidia/cuda:8.0-cudnn6-devel-ubuntu16.04

WORKDIR /root

# Add some dependencies
RUN apt-get update && \
apt-get install -y --no-install-recommends \
build-essential \
cmake \
git \
curl \
vim \
software-properties-common \
libjpeg-dev \
libpng-dev \
ncurses-dev \
lua5.2 \
lua5.2-dev \
luajit \
python-dev \
python3-dev \
ruby-dev \
libpng12-0 \
libgtk2.0-dev && \
rm -rf /var/lib/apt/lists/*


# Build Vim8
RUN git clone https://github.com/vim/vim

WORKDIR /root/vim
RUN git checkout -b v8.0.0008 && \
./configure --with-features=huge --enable-multibyte --enable-luainterp=dynamic --enable-gpm --enable-cscope --enable-fontset --enable-fail-if-missing --prefix=/usr/local --enable-pythoninterp=dynamic --enable-python3interp=dynamic --enable-rubyinterp=dynamic && \
make && \
make install


# Install Vim Plugin (Only Vim8)
RUN git clone https://github.com/kskdev/vim && \
mkdir /root/.vim && \
cp vim/*.toml /root/.vim/ && \
mv vim/vimrc /root/.vimrc


# Add Alias Commands
WORKDIR /root
RUN echo "alias c='clear'" >> /root/.bashrc && \
 echo "alias use='du -d 1 -h'" >> /root/.bashrc && \
 echo "alias vi='vim'" >> /root/.bashrc


# Install Anaconda3
ENV LATEST_CONDA "5.3.1"
ENV PATH="/root/anaconda3/bin:${PATH}"
RUN curl --silent -O https://repo.continuum.io/archive/Anaconda3-$LATEST_CONDA-Linux-x86_64.sh && \
    bash Anaconda3-$LATEST_CONDA-Linux-x86_64.sh -b -p /root/anaconda3  & \
    rm Anaconda3-$LATEST_CONDA-Linux-x86_64.sh

# Install External Libs for Deep Learning
RUN conda install -c menpo opencv3
RUN conda install pytorch==1.0.0 torchvision==0.2.1 cuda80 -c pytorch
RUN pip install tensorboardX==1.5

# Port forward  6006:For TensorboardX , 8888:For Jupyter
EXPOSE 6006 8888

# RUN /bin/bash && apt-get clean && apt-get autoremove


