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

# Copy the files necessary to run the voice
WORKDIR /opt/ext
COPY ext/*.mdl ipd_clean_slt2018.mdl

WORKDIR /opt/festival/lib/voices/is/lvl_is_v0_clunits
COPY voice/festvox/*.scm festvox/
COPY voice/festival/clunits/lvl_is_v0.catalogue festival/clunits/lvl_is_v0.catalogue
COPY voice/festival/trees/lvl_is_v0.tree festival/trees/lvl_is_v0.tree
COPY voice/mcep/*.mcep mcep/
COPY voice/wav wav

# create text2wave.sh and input.txt in this dockerfile
WORKDIR /opt/voice
COPY voice/festvox festvox
RUN echo "halló ég kann að tala íslensku" > input.txt
RUN docvar=$(echo -n "/opt/festival/bin/text2wave -eval festvox/lvl_is_v0_clunits.scm ") \
    && docvar2=$(echo -n "-eval '(voice_lvl_is_v0_clunits)' \$1") \
    && echo $docvar $docvar2 > text2wave.sh

WORKDIR /opt/voice
ENTRYPOINT ["/bin/bash", "./text2wave.sh"]
CMD ["input.txt"]
