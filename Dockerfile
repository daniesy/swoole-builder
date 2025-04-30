FROM alpine:latest as builder

RUN apk add --no-cache  --repository http://dl-cdn.alpinelinux.org/alpine/edge/community php84-dev \
    wget \
    make \
    g++ \
    zip 


RUN cd /tmp && \
    wget -O swoole.zip https://github.com/swoole/swoole-src/archive/v6.0.2.zip && \
    unzip swoole.zip

WORKDIR /tmp/swoole-src-6.0.2

RUN phpize84
RUN ./configure --with-php-config=/usr/bin/php-config84
RUN make && make install
