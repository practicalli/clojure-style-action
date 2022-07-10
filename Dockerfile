FROM alpine:3.14

## Install Reviewdog
ENV REVIEWDOG_VERSION=v0.12.0
RUN wget -O - -q https://raw.githubusercontent.com/reviewdog/reviewdog/master/install.sh| sh -s -- -b /usr/local/bin/ ${REVIEWDOG_VERSION}

## Install cljstyle
ENV CLJSTYLE_VERSION=v0.15.0
RUN apk --no-cache add wget curl git which
# RUN curl -sLO https://raw.githubusercontent.com/greglook/cljstyle/main/script/install-cljstyle | sh -s -- --dir /usr/local/bin/ --version ${CLJSTYLE_VERSION}

# Create install directory for cljstyle
RUN mkdir -p /install

# Set Docker working directory
WORKDIR /install

RUN wget https://github.com/greglook/cljstyle/releases/download/0.15.0/cljstyle_0.15.0_linux.tar.gz

RUN tar zvxf cljstyle_0.15.0_linux.tar.gz -C /usr/local/bin/

RUN which cljstyle

COPY style.sh /style.sh

ENTRYPOINT ["sh", "/style.sh"]
