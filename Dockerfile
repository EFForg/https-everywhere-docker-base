FROM python:2.7
MAINTAINER William Budington "bill@eff.org"

RUN apt-get update && \
  apt-get install -y --no-install-recommends \
    libxml2-dev \
    libxml2-utils \
    python-dev \
    libcurl4-openssl-dev \
    python-lxml \
    python-software-properties \
    rsync \
    unzip \
    xvfb \
    iceweasel \
    chromium && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/* \
    /tmp/* \
    /var/tmp/*
