FROM nvidia/cuda:10.0-cudnn7-devel-ubuntu16.04
ENV HOME /root
WORKDIR $HOME


# Add some commands
RUN apt update && \
 apt install -y --no-install-recommends \
 build-essential \
 cmake \
 git \
 curl \
 libjpeg-dev \
 libpng-dev \
 software-properties-common && \
 rm -rf /var/lib/apt/lists/*


# Install Vim8
RUN add-apt-repository ppa:jonathonf/vim && \
 apt update && \
 apt install -y vim

# Install Vim Plugin (Only Vim8)
RUN git clone https://github.com/kskdev/vim && \
 mkdir $HOME/.vim && \
 cp vim/*.toml $HOME/.vim/ && \
 mv vim/vimrc $HOME/.vimrc && \
 rm -rf vim
 #  /bin/bash -c 'vim -c ":silent! call dein#install() | :q"'  # Cannot install vim plugins while build the Image..


# Port forward  6006:For TensorboardX , 8888:For Jupyter
EXPOSE 6006 8888


# Install Anaconda3
ENV LATEST_CONDA "5.3.1"
ENV PATH=$HOME"/Anaconda3/bin:${PATH}"
RUN curl --silent -O https://repo.continuum.io/archive/Anaconda3-$LATEST_CONDA-Linux-x86_64.sh && \
 bash Anaconda3-$LATEST_CONDA-Linux-x86_64.sh -b -p $HOME/Anaconda3


# Install Others Libraries
RUN conda install -c conda-forge \
 jupyterlab \
 umap-learn \
 opencv

# Deep Learning Library
RUN conda install \
 pytorch=1.0.0 \
 torchvision=0.2.1 \
 cudatoolkit=10.0 \
 -c pytorch

RUN pip install \
 bhtsne==0.1.9 \
 tensorboardX==1.5


# Add Alias Commands
RUN rm $HOME/Anaconda3-$LATEST_CONDA-Linux-x86_64.sh && \
 echo "alias c='clear'" >> $HOME/.bashrc && \
 echo "alias use='du -d 1 -h'" >> $HOME/.bashrc && \
 echo "alias vi='vim'" >> $HOME/.bashrc  && \
 /bin/bash && \
 apt clean && \
 apt autoremove

