FROM golang:1.9-alpine3.7

RUN apk add --update \
    git \
    glide \
    make \
    sudo \
  && rm -rf /var/cache/apk/*

COPY entrypoint.sh /usr/bin/entrypoint
COPY sudoers /etc/sudoers

ENTRYPOINT ["/usr/bin/entrypoint"]
