FROM ubuntu:xenial
MAINTAINER Þorsteinn Daði Gunnarsson <thorsteinng@ru.is>

RUN apt-get update && apt-get install -y \
      automake \
      bc \
      curl \
      g++ \
      git \
      libc-dev \
      libreadline-dev \
      libtool \
      make \
      ncurses-dev \
      nvi \
      pkg-config \
      python \
      python-dev \
      python-setuptools \
      python-pip \
      python3 \
      unzip \
      wavpack \
      wget \
      zip \
      zlib1g-dev \
      sox \
      swig \
    && rm -rf /var/lib/apt/lists/*

ENV LC_ALL C.UTF-8

# Fetch and prepare Festival & friends
WORKDIR /opt
RUN curl -L http://festvox.org/packed/festival/2.5/festival-2.5.0-release.tar.gz | \
    tar xz --no-same-owner --no-same-permissions && \
    curl -L http://festvox.org/packed/festival/2.5/speech_tools-2.5.0-release.tar.gz | \
    tar xz --no-same-owner --no-same-permissions && \
    curl -L http://festvox.org/packed/festival/2.5/festlex_CMU.tar.gz | \
    tar xz --no-same-owner --no-same-permissions && \
    curl -L http://festvox.org/packed/festival/2.5/festlex_OALD.tar.gz | \
    tar xz --no-same-owner --no-same-permissions && \
    curl -L http://festvox.org/packed/festival/2.5/festlex_POSLEX.tar.gz | \
    tar xz --no-same-owner --no-same-permissions && \
    curl -L http://festvox.org/packed/festival/2.5/voices/festvox_kallpc16k.tar.gz | \
    tar xz --no-same-owner --no-same-permissions && \
    curl -L http://festvox.org/packed/festvox/2.8/festvox-2.8.0-release.tar.gz | \
    tar xz --no-same-owner --no-same-permissions

ENV ESTDIR /opt/speech_tools
ENV FESTVOXDIR /opt/festvox
ENV SPTKDIR /opt

# Build the Edinburgh Speech Tools
WORKDIR /opt/speech_tools
RUN ./configure && make

# Build Festival
WORKDIR /opt/festival
RUN ./configure && make

# Build Festvox
WORKDIR /opt/festvox
RUN ./configure && make

RUN pip install --upgrade pip \
    && pip install numpy \
    && pip install git+https://github.com/sequitur-g2p/sequitur-g2p@master

COPY ext/*.mdl /opt/ext/ipd_clean_slt2018.mdl
COPY voice /opt/voice
WORKDIR /opt/voice
ENTRYPOINT ["/bin/bash", "./utt2wave.sh"]
CMD ["input.txt"]
