FROM ubuntu:latest
MAINTAINER William Budington "bill@eff.org"

RUN apt-get update && \
  apt-get install -y --no-install-recommends \
    python2.7 \
    python-pip \
    gcc \
    git-core \
    chromium-chromedriver \
    libxml2-dev \
    libxml2-utils \
    python-dev \
    libcurl4-openssl-dev \
    python-lxml \
    python-software-properties \
    rsync \
    unzip \
    xvfb \
    firefox \
    chromium-browser && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/* \
    /tmp/* \
    /var/tmp/*

RUN pip install setuptools
