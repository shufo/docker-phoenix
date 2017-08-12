FROM erlang:20-alpine
MAINTAINER shufo


ENV REFRESHED_AT 2017-08-12
ENV ELIXIR_VERSION 1.5.1
ENV HOME /root

# Install Erlang/Elixir
RUN echo 'http://dl-cdn.alpinelinux.org/alpine/edge/main' >> /etc/apk/repositories && \
    echo 'http://dl-cdn.alpinelinux.org/alpine/edge/community' >> /etc/apk/repositories && \
    apk -U upgrade && \
    apk --update --no-cache add ncurses-libs git make g++ wget python ca-certificates openssl && \
    update-ca-certificates --fresh && \
    wget https://github.com/elixir-lang/elixir/releases/download/v${ELIXIR_VERSION}/Precompiled.zip && \
    mkdir -p /opt/elixir-${ELIXIR_VERSION}/ && \
    unzip Precompiled.zip -d /opt/elixir-${ELIXIR_VERSION}/ && \
    rm Precompiled.zip && \
    rm -rf /var/cache/apk/*

# Add local node module binaries to PATH
ENV PATH $PATH:node_modules/.bin:/opt/elixir-${ELIXIR_VERSION}/bin

# Install Hex+Rebar
RUN mix local.hex --force && \
    mix local.rebar --force && \
    mix hex.info

EXPOSE 4000

CMD ["sh", "-c", "mix deps.get && mix phoenix.server"]
