FROM alpine:latest
MAINTAINER shufo


ENV REFRESHED_AT 2016-03-25
ENV ELIXIR_VERSION 1.2.3
ENV HOME /root

# Install Erlang/Elixir
RUN echo 'http://dl-cdn.alpinelinux.org/alpine/edge/main' >> /etc/apk/repositories && \
    echo 'http://dl-cdn.alpinelinux.org/alpine/edge/community' >> /etc/apk/repositories && \
    apk -U upgrade && \
    apk --update --no-cache add ncurses-libs git make g++ wget python ca-certificates openssl nodejs \
                     erlang erlang-dev erlang-kernel erlang-hipe erlang-compiler \
                     erlang-stdlib erlang-erts erlang-tools erlang-syntax-tools erlang-sasl \
                     erlang-crypto erlang-public-key erlang-ssl erlang-ssh erlang-asn1 erlang-inets \
                     erlang-inets erlang-mnesia erlang-odbc erlang-xmerl \
                     erlang-erl-interface erlang-parsetools erlang-eunit && \
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

CMD ["sh", "-c", "mix deps.get && mix phoenix.server"]
