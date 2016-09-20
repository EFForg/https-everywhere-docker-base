FROM ubuntu:latest
MAINTAINER William Budington "bill@eff.org"

RUN apt-get update && \
  apt-get install -y --no-install-recommends \
    python2.7 \
    python-pip \
    gcc \
    git-core \
    chromium-chromedriver \
    libgtk-3-0 \
    curl \
    bzip2 \
    libxml2-dev \
    libxml2-utils \
    python-dev \
    libcurl4-openssl-dev \
    libssl-dev \
    python-lxml \
    python-software-properties \
    rsync \
    unzip \
    xvfb \
    chromium-browser \
    miredo && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/* \
    /tmp/* \
    /var/tmp/*

RUN STABLE_VERSION=$(curl -D /dev/stdout "https://download.mozilla.org/?product=firefox-latest&os=linux64&lang=en_US" 2>&1 | sed -n '/Location: /{s|.*/firefox-\(.*\)\.tar.*|\1|p;q;}') && \
    DEV_VERSION=$(curl -D /dev/stdout "https://download.mozilla.org/?product=firefox-aurora-latest-ssl&os=linux64&lang=en-US" 2>&1 | sed -n '/Location: /{s|.*/firefox-\(.*\)\.tar.*|\1|p;q;}') && \
    ESR_VERSION=$(curl -D /dev/stdout "https://download.mozilla.org/?product=firefox-esr-latest&os=linux64&lang=en_US" 2>&1 | sed -n '/Location: /{s|.*/firefox-\(.*\)\.tar.*|\1|p;q;}') && \
    curl -s -o firefox-latest.tar.bz2 "https://archive.mozilla.org/pub/firefox/tinderbox-builds/mozilla-release-linux64-add-on-devel/1474046055/firefox-49.0.en-US.linux-x86_64-add-on-devel.tar.bz2" && \
    curl -s -o firefox-dev.tar.bz2 "https://ftp.mozilla.org/pub/firefox/nightly/latest-mozilla-aurora/firefox-$DEV_VERSION.tar.bz2" && \
    curl -s -o firefox-esr-latest.tar.bz2 "https://ftp.mozilla.org/pub/firefox/releases/$ESR_VERSION/linux-x86_64/en-US/firefox-$ESR_VERSION.tar.bz2" && \
    mkdir firefox-latest && \
    mkdir firefox-dev && \
    mkdir firefox-esr-latest && \
    tar -jxvf firefox-latest.tar.bz2 -C firefox-latest && \
    tar -jxvf firefox-dev.tar.bz2 -C firefox-dev && \
    tar -jxvf firefox-esr-latest.tar.bz2 -C firefox-esr-latest && \
    rm firefox-latest.tar.bz2 && \
    rm firefox-dev.tar.bz2 && \
    rm firefox-esr-latest.tar.bz2

RUN pip install setuptools wheel

ENV PYCURL_SSL_LIBRARY=openssl
RUN pip install -U --force-reinstall pycurl

ENV DISPLAY :0
