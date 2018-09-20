FROM ubuntu:16.04

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
  && apt-get install -y \
  software-properties-common \
  tzdata \
  locales \
  && echo "Australia/Sydney" > /etc/timezone \
  && dpkg-reconfigure -f noninteractive tzdata \
  && echo 'LANG="en_US.UTF-8"'>/etc/default/locale \
  && locale-gen en_US en_US.UTF-8 \
  && dpkg-reconfigure --frontend=noninteractive locales \
  && add-apt-repository ppa:certbot/certbot \
  && apt-get update \
  && apt-get -y install \
  curl \
  python-certbot-apache \
  && apt-get clean

# Smoke test
RUN certbot --version