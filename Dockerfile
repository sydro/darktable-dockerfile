FROM ubuntu:16.04

ENV version 2.4.4

RUN apt-get update && \
    apt-get -y install debhelper dpkg-dev fakeroot wget libgphoto2-6 && \
    apt-get -y build-dep darktable && \
    cd /root && wget https://github.com/darktable-org/darktable/releases/download/release-${version}/darktable-${version}.tar.xz && \
    tar -xvf darktable-${version}.tar.xz && \
    cd darktable-${version} && \
    ./build.sh --prefix /opt/darktable --build-type Release && \
    cmake --build "/root/darktable-${version}/build" --target install -- -j4 && \
    apt-get -y remove debhelper dpkg-dev fakeroot && apt-get clean && rm -r /root/darktable-${version}*

RUN useradd -ms /bin/bash darktable

USER darktable
WORKDIR /home/darktable

CMD /opt/darktable/bin/darktable
