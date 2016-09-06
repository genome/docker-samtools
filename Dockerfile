FROM ubuntu:xenial
MAINTAINER Thomas B. Mooney <tmooney@genome.wustl.edu>

LABEL \
  version="1.3.1" \
  description="Samtools image for use in Workflows"

RUN apt-get update && apt-get install -y \
  bzip2 \
  g++ \
  make \
  ncurses-dev \
  wget \
  zlib1g-dev

ENV SAMTOOLS_INSTALL_DIR=/opt/samtools

WORKDIR /tmp
RUN wget https://github.com/samtools/samtools/releases/download/1.3.1/samtools-1.3.1.tar.bz2 && \
  tar --bzip2 -xf samtools-1.3.1.tar.bz2

WORKDIR /tmp/samtools-1.3.1
RUN ./configure --enable-plugins --prefix=$SAMTOOLS_INSTALL_DIR && \
  make all all-htslib && \
  make install install-htslib

WORKDIR /
RUN ln -s $SAMTOOLS_INSTALL_DIR/bin/samtools /usr/bin/samtools && \
  rm -rf /tmp/samtools-1.3.1

ENTRYPOINT ["/usr/bin/samtools"]
