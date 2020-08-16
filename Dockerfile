FROM alpine:latest as builder

RUN apk add --no-cache  --repository http://dl-cdn.alpinelinux.org/alpine/edge/community php7-dev \
    wget \
    make \
    g++ \
    zip 

RUN cd /tmp && \
    wget -O swoole.zip https://github.com/swoole/swoole-src/archive/v4.5.2.zip && \
    unzip swoole.zip && \
    cd swoole-src-4.5.2 && \
    ls && \
    phpize && \
    ./configure && \
    make && make install
