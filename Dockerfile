FROM elixir:1.6.1-alpine
MAINTAINER shufo


ENV REFRESHED_AT 2018-02-19
ENV ELIXIR_VERSION 1.6.1
ENV HOME /root

# Install Erlang/Elixir
RUN apk -U upgrade && \
    apk --update --no-cache add ncurses-libs git make g++ wget python ca-certificates openssl && \
    update-ca-certificates --fresh && \
    rm -rf /var/cache/apk/*

# Add local node module binaries to PATH
ENV PATH $PATH:node_modules/.bin:/usr/local/bin

# Install Hex+Rebar
RUN mix local.hex --force && \
    mix local.rebar --force && \
    mix hex.info

EXPOSE 4000

CMD ["sh", "-c", "mix deps.get && mix phoenix.server"]
