FROM ubuntu:18.04

ENV version 3.1.0

RUN sed -Ei 's/^# deb-src /deb-src /' /etc/apt/sources.list && apt-get update && \
    apt-get -y install debhelper dpkg-dev fakeroot wget libgphoto2-6 git && \
    apt-get -y build-dep darktable && \
    cd root && git clone https://github.com/darktable-org/darktable.git && cd darktable && \
    git checkout release-${version} && git submodule init && git submodule update && \
    ./build.sh --prefix /opt/darktable --build-type Release && \                                                                                
    cmake --build "/root/darktable/build" --target install -- -j4 && \
    apt-get -y remove debhelper dpkg-dev fakeroot git && apt-get clean && rm -rf /root/darktable*

RUN useradd -ms /bin/bash darktable

USER darktable
WORKDIR /home/darktable

CMD /opt/darktable/bin/darktable
