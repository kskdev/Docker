FROM nvidia/cuda:8.0-cudnn6-devel-ubuntu16.04
ENV WorkDir "/root"
WORKDIR $WorkDir


# Add some commands
RUN apt-get update && \
 apt-get install -y --no-install-recommends \
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
 apt-get update && \
 apt-get install -y vim

# Install Vim Plugin (Only Vim8)
RUN git clone https://github.com/kskdev/vim && \
 mkdir $WorkDir/.vim && \
 cp vim/*.toml $WorkDir/.vim/ && \
 mv vim/vimrc $WorkDir/.vimrc && \
 rm -rf vim
 #  /bin/bash -c 'vim -c ":silent! call dein#install() | :q"'  # ビルドの段階でインストールが出来なかった


# # Port forward  6006:For TensorboardX , 8888:For Jupyter
EXPOSE 6006 8888


# Install Anaconda2
ENV LATEST_CONDA "5.3.1"
ENV PATH=$WorkDir"/Anaconda2/bin:${PATH}"
RUN curl --silent -O https://repo.continuum.io/archive/Anaconda2-$LATEST_CONDA-Linux-x86_64.sh && \
 bash Anaconda2-$LATEST_CONDA-Linux-x86_64.sh -b -p $WorkDir/Anaconda2


# Deep Learning Library
# RUN conda install -c pytorch pytorch==0.4.0 torchvision==0.2.1 cuda80
# TODO pytorch 0.4.0 がcondaで入らない...
RUN conda install -c pytorch \
 pytorch==1.0.0 \
 torchvision==0.2.1 \
 cuda80

RUN conda install -c menpo opencv
RUN pip install --upgrade pip && \
 pip install \
 bhtsne==0.1.9 \
 tensorboardX==1.5


# Add Alias Commands
RUN rm $WorkDir/Anaconda2-$LATEST_CONDA-Linux-x86_64.sh && \
 echo "alias c='clear'" >> $WorkDir/.bashrc && \
 echo "alias use='du -d 1 -h'" >> $WorkDir/.bashrc && \
 echo "alias vi='vim'" >> $WorkDir/.bashrc  && \
 /bin/bash && \
 apt-get clean && \
 apt-get autoremove

