# https://github.com/qntfy/nvidia-docker-anaconda

FROM nvidia/cuda:8.0-cudnn6-devel


# Add some dependencies
RUN apt-get clean && apt-get update -y -qq && \
 apt-get install -y curl git build-essential software-properties-common


# Build Vim8
WORKDIR /root
RUN apt-get update
RUN apt-get -f install
RUN apt-get install -y git build-essential ncurses-dev lua5.2 lua5.2-dev luajit python-dev python3-dev ruby-dev libpng12-0 libgtk2.0-dev
RUN git clone https://github.com/vim/vim
WORKDIR /root/vim
RUN git checkout -b v8.0.0008
RUN ./configure --with-features=huge --enable-multibyte --enable-luainterp=dynamic --enable-gpm --enable-cscope --enable-fontset --enable-fail-if-missing --prefix=/usr/local --enable-pythoninterp=dynamic --enable-python3interp=dynamic --enable-rubyinterp=dynamic
RUN make && make install


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
ENV LATEST_CONDA "4.4.0"
ENV PATH="/root/anaconda3/bin:${PATH}"
RUN curl --silent -O https://repo.continuum.io/archive/Anaconda3-$LATEST_CONDA-Linux-x86_64.sh \
    && bash Anaconda3-$LATEST_CONDA-Linux-x86_64.sh -b -p /root/anaconda3


# Install External Libs for Deep Learning
RUN conda install -c menpo opencv3
RUN conda install pytorch==0.4.0 torchvision==0.2.1 cuda80 -c pytorch
RUN conda install -c conda-forge visdom
RUN conda install -c conda-forge dominate
RUN pip install cupy==4.2.0
RUN pip install chainer==4.2.0
RUN conda remove pyqt
# pyqt disturb to do training by chainer trainer.
 

RUN /bin/bash && apt-get clean && apt-get autoremove


