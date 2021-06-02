FROM alpine:latest as builder

RUN apk add --no-cache  --repository http://dl-cdn.alpinelinux.org/alpine/edge/community php8-dev \
    wget \
    make \
    g++ \
    zip 

RUN cd /tmp && \
    wget -O swoole.zip https://github.com/swoole/swoole-src/archive/v4.6.7.zip && \
    unzip swoole.zip

WORKDIR /tmp/swoole-src-4.6.7

RUN phpize8 
RUN ./configure --with-php-config=/usr/bin/php-config8
RUN make && make install
