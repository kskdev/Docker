# https://github.com/qntfy/nvidia-docker-anaconda

FROM nvidia/cuda:9.0-cudnn7-devel

# Add some dependencies
RUN apt-get clean && apt-get update -y -qq
RUN apt-get install -y curl git build-essential vim

ENV LATEST_CONDA "4.4.0"
ENV PATH="/root/anaconda3/bin:${PATH}"

RUN curl --silent -O https://repo.continuum.io/archive/Anaconda3-$LATEST_CONDA-Linux-x86_64.sh \
    && bash Anaconda3-$LATEST_CONDA-Linux-x86_64.sh -b -p /root/anaconda3

RUN conda install -c menpo opencv3
RUN conda install pytorch torchvision cuda90 -c pytorch
RUN conda install -c conda-forge visdom
RUN conda install -c conda-forge dominate
RUN /bin/bash
# RUN apt-get clean
RUN apt-get clean && apt-get autoremove

