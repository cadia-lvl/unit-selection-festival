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

RUN pip3 install --upgrade pip \
    && pip3 install numpy \
    && pip3 install git+https://github.com/sequitur-g2p/sequitur-g2p@master \
    && pip3 install torch==1.7.1+cpu --find-links https://download.pytorch.org/whl/torch_stable.html \
    && pip3 install fairseq

# Copy the files necessary to run the voice
ENV G2P_MODEL_DIR=/app/fairseq_g2p/

WORKDIR /app/fairseq_g2p/
COPY ext/checkpoints fairseq_g2p/checkpoints
COPY ext/data-bin fairseq_g2p/data-bin

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
