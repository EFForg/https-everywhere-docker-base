FROM ubuntu:bionic
MAINTAINER William Budington "bill@eff.org"

RUN apt-get update && \
  apt-get install -y --no-install-recommends \
    python3.6 \
    python2.7 \
    python3.6-dev \
    python2.7-dev \
    python3-pip \
    python-pip \
    git-core \
    libdpkg-perl \
    gcc \
    curl \
    libxml2-dev \
    libcurl4-openssl-dev \
    libssl-dev \
    ca-certificates \
    miredo \
    tor && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/* \
    /tmp/* \
    /var/tmp/*

RUN pip install setuptools wheel
RUN pip3 install setuptools wheel

ENV PYCURL_SSL_LIBRARY=openssl
RUN pip install -U --force-reinstall pycurl
RUN pip3 install -U --force-reinstall pycurl
