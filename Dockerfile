FROM ubuntu:bionic
MAINTAINER Thomas B. Mooney <tmooney@genome.wustl.edu>

LABEL \
  version="1.9" \
  description="Samtools image for use in Workflows"

RUN apt-get update && apt-get install -y \
  bzip2 \
  ca-certificates \
  gawk \
  g++ \
  libbz2-dev \
  libcrypto++-dev \
  libcurl4 \
  libcurl4-gnutls-dev \
  libncurses5-dev \
  libssl-dev \
  liblzma-dev \
  make \
  ncurses-dev \
  perl \
  python3 \
  wget \
  zlib1g-dev \
  && apt-get autoclean && rm -rf /var/lib/apt/lists/*

ENV SAMTOOLS_INSTALL_DIR=/opt/samtools

WORKDIR /tmp
RUN wget https://github.com/samtools/samtools/releases/download/1.16.1/samtools-1.16.1.tar.bz2 && \
  tar --bzip2 -xf samtools-1.16.1.tar.bz2

WORKDIR /tmp/samtools-1.16.1
RUN ./configure --prefix=$SAMTOOLS_INSTALL_DIR && \
  make && \
  make install

WORKDIR /
RUN ln -s $SAMTOOLS_INSTALL_DIR/bin/samtools /usr/bin/samtools && \
  rm -rf /tmp/samtools-1.16.1

ENTRYPOINT ["/usr/bin/samtools"]

