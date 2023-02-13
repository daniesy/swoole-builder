# swoole-builder

How to use:

    FROM daniesy/swoole-builder:latest as builder

    FROM alpine:latest as osslsigncode

    RUN apk update && apk add libcurl curl-dev openssl-dev autoconf build-base automake libtool zip
    RUN wget -O osslsigncode.zip https://github.com/mtrojnar/osslsigncode/archive/2.1.zip
    RUN unzip osslsigncode.zip
    WORKDIR /osslsigncode-2.1
    RUN ./autogen.sh && ./configure && make && make install && make clean

    FROM alpine:latest

    RUN apk add --no-cache --repository http://dl-cdn.alpinelinux.org/alpine/edge/community php81 \
        php81-json \
        php81-zip \
        libstdc++ \
        file \
        go \
        git \
        zip \
        openssl-dev

    COPY --from=builder /usr/lib/php81/modules/swoole.so /usr/lib/php81/modules/
    COPY --from=builder /usr/include/php81/ext/swoole /usr/include/php81/ext/swoole
    COPY --from=osslsigncode /usr/local/bin/osslsigncode /usr/local/bin/osslsigncode

    RUN touch /etc/php81/conf.d/swoole.ini && \
        echo 'extension=swoole.so' > /etc/php81/conf.d/swoole.ini

    RUN mkdir /app
    WORKDIR /app
    COPY . .
    CMD ["php81", "server.php"]
    EXPOSE 9501
