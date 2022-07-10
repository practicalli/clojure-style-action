FROM alpine:3.14

## Install Reviewdog
ENV REVIEWDOG_VERSION=v0.12.0
RUN wget -O - -q https://raw.githubusercontent.com/reviewdog/reviewdog/master/install.sh| sh -s -- -b /usr/local/bin/ ${REVIEWDOG_VERSION}

## Install cljstyle
RUN wget -O - -q https://raw.githubusercontent.com/greglook/cljstyle/main/script/install-cljstyle | sh -s -- -b /usr/local/bin/

COPY style.sh /style.sh

ENTRYPOINT ["bash", "/style.sh"]
