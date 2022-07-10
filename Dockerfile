FROM alpine:3.14

## Install Reviewdog
ENV REVIEWDOG_VERSION=v0.12.0
RUN wget -O - -q https://raw.githubusercontent.com/reviewdog/reviewdog/master/install.sh| sh -s -- -b /usr/local/bin/ ${REVIEWDOG_VERSION}

## Install cljstyle
ENV CLJSTYLE_VERSION=v0.15.0
RUN apk --no-cache add curl git which
RUN curl -sLO https://raw.githubusercontent.com/greglook/cljstyle/main/script/install-cljstyle | sh -s -- --dir /usr/local/bin/ --version ${CLJSTYLE_VERSION}

RUN which cljstyle

COPY style.sh /style.sh

ENTRYPOINT ["sh", "/style.sh"]
