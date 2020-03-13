FROM ubuntu:bionic
LABEL maintainer="William Budington <bill@eff.org>"

RUN set -ex; \
  \
  apt-get update; \
  apt-get install -y --no-install-recommends \
    python3.6 \
    python3.6-dev \
    python3-pip \
    git-core \
    libdpkg-perl \
    gcc \
    curl \
    libxml2-dev \
    libcurl4-openssl-dev \
    libssl-dev \
    ca-certificates \
    miredo \
    splitpatch \
    tor \
  ; \
  rm -rf /var/lib/apt/lists/*

RUN pip3 install --no-cache-dir setuptools wheel

ENV PYCURL_SSL_LIBRARY=openssl
RUN pip3 install --no-cache-dir -U --force-reinstall pycurl
