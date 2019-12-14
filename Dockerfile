FROM python:3-alpine

RUN apk add --no-cache \
        python3-dev \
        build-base \
        libffi-dev \
        ca-certificates \
        openssl && \
    pip install --upgrade \
        radicale \
        passlib \
        bcrypt && \
    apk del \
        python3-dev \
        build-base \
        libffi-dev

VOLUME /data
VOLUME /config

EXPOSE 5232

ADD files/entrypoint.sh /
ENTRYPOINT /entrypoint.sh
