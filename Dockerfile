FROM alpine:latest
MAINTAINER shufo


ENV REFRESHED_AT 2017-01-05
ENV ELIXIR_VERSION 1.4.0
ENV HOME /root

# Install Erlang/Elixir
RUN apk -U upgrade && \
    apk --update --no-cache add ncurses-libs git make g++ wget python ca-certificates openssl nodejs mysql-client imagemagick \
                     erlang erlang-dev erlang-kernel erlang-hipe erlang-compiler \
                     erlang-stdlib erlang-erts erlang-tools erlang-syntax-tools erlang-sasl \
                     erlang-crypto erlang-public-key erlang-ssl erlang-ssh erlang-asn1 erlang-inets \
                     erlang-inets erlang-mnesia erlang-odbc erlang-xmerl \
                     erlang-erl-interface erlang-parsetools erlang-eunit \
                     inotify-tools && \
    update-ca-certificates --fresh && \
    npm install -g brunch babel-brunch sass-brunch javascript-brunch css-brunch clean-css-brunch uglify-js-brunch && \
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
