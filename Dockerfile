FROM ubuntu:xenial
MAINTAINER William Budington "bill@eff.org"

RUN echo "deb http://deb.torproject.org/torproject.org xenial main" > /etc/apt/sources.list.d/tor.list

RUN gpg --keyserver keys.gnupg.net --recv A3C4F0F979CAA22CDBA8F512EE8CBC9E886DDD89 && \
  gpg --export A3C4F0F979CAA22CDBA8F512EE8CBC9E886DDD89 | apt-key add -

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
    libdbus-glib-1-2 \
    miredo \
    tor && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/* \
    /tmp/* \
    /var/tmp/*

RUN curl -sLO "https://github.com/mozilla/geckodriver/releases/download/v0.16.1/geckodriver-v0.16.1-linux64.tar.gz" && \
    tar -zxvf "geckodriver-v0.16.1-linux64.tar.gz" && \
    rm -f "geckodriver-v0.16.1-linux64.tar.gz" && \
    mv geckodriver /usr/bin/geckodriver && \
    chmod +x /usr/bin/geckodriver

RUN STABLE_VERSION=$(curl -I 'https://download.mozilla.org/?product=firefox-latest&os=linux64&lang=en_US' 2>&1 | sed -n '/Location: /{s|.*/firefox-\(.*\)\.tar.*|\1|p;q;}') && \
    DEV_VERSION=$(curl -I 'https://download.mozilla.org/?product=firefox-devedition-latest-ssl&os=linux64&lang=en-US' 2>&1 | sed -n '/Location: /{s|.*/firefox-\(.*\)\.tar.*|\1|p;q;}') && \
    ESR_VERSION=$(curl -I 'https://download.mozilla.org/?product=firefox-esr-latest&os=linux64&lang=en_US' 2>&1 | sed -n '/Location: /{s|.*/firefox-\(.*\)\.tar.*|\1|p;q;}') && \
    curl -s -o firefox-latest.tar.bz2 "https://archive.mozilla.org/pub/firefox/tinderbox-builds/mozilla-release-linux64-add-on-devel/1496944705/firefox-54.0.en-US.linux-x86_64-add-on-devel.tar.bz2" && \
    curl -s -o firefox-dev.tar.bz2 "https://public-artifacts.taskcluster.net/O40i9aIpTWObZm_vdudb6A/0/public/build/target.tar.bz2" && \
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
