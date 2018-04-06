# ==================================================================
# module list
# ------------------------------------------------------------------
# python        3.6    (apt)
# chainer       latest (pip)
# ==================================================================

FROM nvidia/cuda:9.0-cudnn7-devel
RUN APT_INSTALL="apt-get install -y --no-install-recommends" && \
    PIP_INSTALL="pip --no-cache-dir install --upgrade" && \
    GIT_CLONE="git clone --depth 10" && \

    rm -rf /var/lib/apt/lists/* \
    /etc/apt/sources.list.d/cuda.list \
    /etc/apt/sources.list.d/nvidia-ml.list && \

    apt-get update && \

# ==================================================================
# tools
# ------------------------------------------------------------------

    DEBIAN_FRONTEND=noninteractive $APT_INSTALL \
    build-essential \
    ca-certificates \
    cmake \
    wget \
    git \
    vim \
    && \


# ==================================================================
# python
# ------------------------------------------------------------------

    DEBIAN_FRONTEND=noninteractive $APT_INSTALL \
    software-properties-common \
    && \
    add-apt-repository ppa:jonathonf/python-3.6 && \
    apt-get update && \
    DEBIAN_FRONTEND=noninteractive $APT_INSTALL \
    python3.6 \
    python3.6-dev \
    && \
    wget -O ~/get-pip.py \
    https://bootstrap.pypa.io/get-pip.py && \
    python3.6 ~/get-pip.py && \
    ln -s /usr/bin/python3.6 /usr/local/bin/python3 && \
    ln -s /usr/bin/python3.6 /usr/local/bin/python && \
    $PIP_INSTALL \
    setuptools \
    && \
    $PIP_INSTALL \
    numpy \
    scipy \
    pandas \
    scikit-learn \
    matplotlib \
    Cython \
    scikit-image \
    pillow \
    opencv-python \
    scikit-image \
    pillow \
    && \

# ==================================================================
# chainer
# ------------------------------------------------------------------

$PIP_INSTALL \
    cupy=="1.0.0.1" \
    chainer=="2.0.0" \
    && \



# ==================================================================
# tensorflow and keras
# ------------------------------------------------------------------

# $PIP_INSTALL \
#     tensorflow_gpu \
#     h5py \
#     keras \
#     && \


# ==================================================================
# config & cleanup
# ------------------------------------------------------------------

    ldconfig && \
    apt-get clean && \
    apt-get autoremove && \
    rm -rf /var/lib/apt/lists/* /tmp/* ~/*



# =================================
# Develop Environment
# =================================

# For Vim
# RUN git clone https://github.com/kskdev/vim
# RUN sh /vim/dein.sh /root/dein
# RUN cp /vim/vimrc /root/.vimrc

