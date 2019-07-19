# 
# ROOT with python3 support
# https://github.com/duartej/dockerfiles-rootpython3
#
# Build ROOT with python3 support (PyROOT is imported
# within python 3 instead of 2)
# 
# Build the image:
# docker build -t duartej/rootpython3:6.18.0 .
FROM phusion/baseimage:0.11
LABEL author="jorge.duarte.campderros@cern.ch" \ 
    version="6.0" \ 
    description="Docker image for ROOT with python3 support"

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]

# -- Update and get needed packages
USER root

RUN apt-get update \
  && install_clean --no-install-recommends software-properties-common \ 
  build-essential \
  python3 \
  python3-dev \ 
  python3-numpy \
  libx11-dev \ 
  libxpm4 \ 
  libxpm-dev \ 
  libxft2 \ 
  libxft-dev \
  libxpm-dev \ 
  libxext-dev \
  libpng16-16 \
  libjpeg8 \ 
  libtiff5 \ 
  libpcre3-dev \
  libssl-dev \ 
  gfortran \ 
  libgsl-dev \ 
  xlibmesa-glu-dev \ 
  libglew-dev \ 
  libmysqlclient-dev \ 
  libfftw3-dev \ 
  libcfitsio-dev \ 
  libgraphviz-dev \ 
  libavahi-compat-libdnssd-dev \ 
  libldap2-dev \ 
  libxml2-dev \ 
  libkrb5-dev \ 
  libgsl-dev \ 
  libqt4-dev \ 
  r-base \ 
  libtbb2 \  
  cmake \ 
  git \ 
  wget

ARG ROOT_VERSION=6.18.00

# ROOT: 6.18/00
RUN mkdir /rootfr \ 
  && wget https://root.cern.ch/download/root_v${ROOT_VERSION}.source.tar.gz -O /rootfr/root.${ROOT_VERSION}.tar.gz \ 
  && tar -xf /rootfr/root.${ROOT_VERSION}.tar.gz -C /rootfr \ 
  && rm -rf /rootfr/root.${ROOT_VERSION}.tar.gz \ 
  && mkdir /rootfr/root \ 
  && cd /rootfr/root-${ROOT_VERSION} \ 
  && cd build \
  && cmake .. \
    -Drpath=ON \
    -Dbuiltin_minuit2=ON \ 
    -Dbuiltin_fftw3=ON \ 
    -Dbuiltin_freetype=ON \
    -Dbuiltin_pcre=ON \
    -Dbuiltin_lzma=ON \
    -Dbuiltin_unuran=ON \
    -Dbuiltin_veccore=ON \
    -Dbuiltin_xrootd=ON \ 
    -Dbuiltin_gsl=ON \
    -Dpython3=ON \
    -DPYTHON_EXECUTABLE:FILEPATH="/usr/bin/python3" \
    -DPYTHON_INCLUDE_DIR:PATH="/usr/include/python3.6m" \
    -DPYTHON_INCLUDE_DIR2:PATH="/usr/include/x86_64-linux-gnu/python3.6m" \
    -DPYTHON_LIBRARY:FILEPATH="/usr/lib/x86_64-linux-gnu/libpython3.6m.so" \
    -DCMAKE_INSTALL_PREFIX=/rootfr/root \
  && cmake --build . -- -j4 \ 
  && cmake --build . --target install \ 
  && rm -rf /rootfr/root-${ROOT-VERSION}

CMD ["/bin/bash","-i"]
