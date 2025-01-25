# syntax=docker/dockerfile:1

FROM alpine:latest

RUN apk update && \
    apk add --no-cache \
        alpine-conf \
        curl \
        bash

RUN setup-user -a appuser && \
    echo 'permit nopass :wheel' > /etc/doas.d/doas.conf

USER appuser

WORKDIR /srv
