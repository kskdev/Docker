FROM ubuntu:16.04
MAINTAINER kosumikedev kosumikedev@gmail.com
RUN sed -i'.bak' -e 's/\/\/archive.ubuntu.com/\/\/ftp.jaist.ac.jp/g' /etc/apt/sources.list
RUN apt-get update
RUN DEBIAN_DEFRONTEND=noninteractive apt-get install -yq texlive-lang-japanese texlive-xetex texlive-fonts-recommended 
RUN apt-get clean -yq
ENV LANG ja_JP.UTF-8
ENV HOME /root
WORKDIR /data
CMD /bin/bash
