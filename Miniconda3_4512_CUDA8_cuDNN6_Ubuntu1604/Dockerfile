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
libpng-dev && \
rm -rf /var/lib/apt/lists/*

# ncurses-dev \
# lua5.2 \
# lua5.2-dev \
# luajit \
# python-dev \
# python3-dev \
# ruby-dev \
# libpng12-0 \
# libgtk2.0-dev && \
# rm -rf /var/lib/apt/lists/*

# Port forward  6006:For TensorboardX , 8888:For Jupyter
EXPOSE 6006 8888


# Install Anaconda3
ENV LATEST_CONDA "4.5.4"
ENV PATH="/root/Miniconda3/bin:${PATH}"
RUN curl --silent -O https://repo.continuum.io/miniconda/Miniconda3-$LATEST_CONDA-Linux-x86_64.sh && \
 bash Miniconda3-$LATEST_CONDA-Linux-x86_64.sh -b -p /root/Miniconda3 && \
 rm /root/Miniconda3-$LATEST_CONDA-Linux-x86_64.sh


# Install External Libs for Deep Learning
RUN conda install -c menpo opencv3
RUN conda install pytorch==1.0.0 torchvision==0.2.1 cuda80 -c pytorch
RUN pip install tensorboardX==1.5

RUN conda install \
 jupyter \
 jupyterlab \
 numpy \
 matplotlib \
 opencv3 \
 pillow \
 scipy \
 scikit-learn \
 pandas \
 cython

# Deep Learning Library
RUN conda install -c pytorch \
 pytorch==0.4.0 \
 torchvision==0.2.1 \
 cuda80

RUN pip install \
 bhtsne==0.1.9 \
 tensorboardX==1.5


# Add Alias Commands
RUN echo "alias c='clear'" >> /root/.bashrc && \
 echo "alias use='du -d 1 -h'" >> /root/.bashrc && \
 echo "alias vi='vim'" >> /root/.bashrc  && \
 /bin/bash && \
 apt-get clean && \
 apt-get autoremove


