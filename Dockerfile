FROM ubuntu:18.04
ARG DEBIAN_FRONTEND=noninteractive
ADD addresses.txt .
ENV TZ=America/Detroit
RUN apt-get update && apt-get -y install \
    autoconf \
    automake \
    curl \
    git \
    libtool \
    pkg-config \
    make --fix-missing && \
    git clone https://github.com/openvenues/libpostal && \
    cd libpostal && \
    ./bootstrap.sh && \
    ./configure --datadir=/libpostal_data --disable-dependency-tracking && \
    make -j2 && \
    make install
WORKDIR /libpostal/src
CMD cat /addresses.txt | ./libpostal --json