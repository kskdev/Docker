FROM nvidia/cuda:8.0-cudnn6-devel
LABEL maintainer="kosum <kosumikedev@gmail.com>"

# Based on ufoym/deepo(URL: https://github.com/ufoym/deepo)

# =================================
# cuda           8.0
# cudnn          v6
# ---------------------------------
# python         3.5
# opencv         latest (git)
# ---------------------------------
# tensorflow_gpu 1.4.0  (pip)
# keras          2.0.9  (pip)
# chainer        2.0.0  (pip)
# ---------------------------------
# bhtsne         0.1.9  (pip) (req: numpy,Cython)
# ---------------------------------

RUN APT_INSTALL="apt-get install -y --no-install-recommends" && \
    PIP_INSTALL="pip --no-cache-dir install --upgrade" && \
    GIT_CLONE="git clone --depth 10" && \


# =================================
# apt
# =================================

    rm -rf /var/lib/apt/lists/* \
           /etc/apt/sources.list.d/cuda.list \
           /etc/apt/sources.list.d/nvidia-ml.list && \

    apt-get update && \
    DEBIAN_FRONTEND=noninteractive $APT_INSTALL \
        apt-utils \
        && \

# =================================
# common tools
# =================================

    DEBIAN_FRONTEND=noninteractive $APT_INSTALL \
        build-essential \
        ca-certificates \
        wget \
        git \
        vim \
        && \

# =================================
# cmake
# =================================

    # fix boost-not-found issue caused by the `apt-get` version of cmake
    $GIT_CLONE https://github.com/Kitware/CMake ~/cmake && \
    cd ~/cmake && \
    ./bootstrap --prefix=/usr/local && \
    make -j"$(nproc)" install && \

# =================================
# python3 and library
# =================================

    DEBIAN_FRONTEND=noninteractive $APT_INSTALL \
        python3-pip \
        python3-dev \
        && \
    ln -s /usr/bin/python3 /usr/local/bin/python && \
    pip3 --no-cache-dir install --upgrade pip && \
    $PIP_INSTALL \
        setuptools \
        numpy \
        scipy \
        pandas \
        scikit-learn \
        matplotlib \
        Cython \
        scikit-image \
        pillow \
        bhtsne=="0.1.9" \
        && \

# =================================
# opencv
# =================================

    DEBIAN_FRONTEND=noninteractive $APT_INSTALL \
        libatlas-base-dev \
        libboost-all-dev \
        libgflags-dev \
        libgoogle-glog-dev \
        libhdf5-serial-dev \
        libleveldb-dev \
        liblmdb-dev \
        libprotobuf-dev \
        libsnappy-dev \
        protobuf-compiler \
        && \

    $GIT_CLONE https://github.com/opencv/opencv ~/opencv && \
    mkdir -p ~/opencv/build && cd ~/opencv/build && \
    cmake -D CMAKE_BUILD_TYPE=RELEASE \
          -D CMAKE_INSTALL_PREFIX=/usr/local \
          -D WITH_IPP=OFF \
          -D WITH_CUDA=OFF \
          -D WITH_OPENCL=OFF \
          -D BUILD_TESTS=OFF \
          -D BUILD_PERF_TESTS=OFF \
          .. && \
    make -j"$(nproc)" install && \

# =================================
# tensorflow
# =================================

    $PIP_INSTALL \
        tensorflow_gpu=="1.4.0" \
        && \



# =================================
# keras
# =================================

    $PIP_INSTALL \
        h5py=="2.7.1" \
        keras=="2.0.9" \
        && \



# =================================
# chainer
# =================================

    $PIP_INSTALL \
        cupy=="1.0.0.1" \
        chainer=="2.0.0" \
        && \



# =================================
# config & cleanup
# =================================

    ldconfig && \
    apt-get clean && \
    apt-get autoremove && \
    rm -rf /var/lib/apt/lists/* /tmp/*  ~/*


# =================================
# Develop Environment
# =================================

# For Vim
RUN git clone https://github.com/kskdev/vim
COPY ./vim/* /tmp/
RUN ls -l /tmp
RUN chmod u+x /tmp/install.sh /tmp/dein.sh
RUN /tmp/dein.sh ~/.vim/dein
RUN cp /tmp/vimrc ~/.vimrc

# Custom bashrc
COPY ./myalias /tmp/
RUN cp /tmp/myalias ~/myalias
RUN echo "source ~/myalias" >> ~/.bashrc






