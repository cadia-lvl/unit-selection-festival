FROM python:3.7-stretch
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
      python3 \
      python3-dev \
      python3-setuptools \
      python3-pip \
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
WORKDIR /usr/local/src
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

ENV ESTDIR /usr/local/src/speech_tools
ENV FESTVOXDIR /usr/local/src/festvox
ENV SPTKDIR /usr/local

# Build the Edinburgh Speech Tools
WORKDIR /usr/local/src/speech_tools
RUN ./configure && make

# Build Festival
WORKDIR /usr/local/src/festival
RUN ./configure && make

# Build Festvox
WORKDIR /usr/local/src/festvox
RUN ./configure && make

RUN pip3 install numpy \
    && pip3 install git+https://github.com/sequitur-g2p/sequitur-g2p@master \
    && pip3 install torch==1.7.1+cpu --find-links https://download.pytorch.org/whl/torch_stable.html \
    && pip3 install fairseq

ENV G2P_MODEL_DIR=/app/fairseq_g2p/

VOLUME ["/usr/local/src/voice"]
VOLUME ["/usr/local/src/ext"]
WORKDIR /usr/local/src/voice
ENTRYPOINT ["/bin/bash", "./run.sh"]
CMD ["../ext/data", "standard"]
