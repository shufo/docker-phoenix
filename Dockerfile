FROM elixir:1.6.0-alpine
MAINTAINER shufo


ENV REFRESHED_AT 2018-01-19
ENV ELIXIR_VERSION 1.6.0
ENV HOME /root

# Install Erlang/Elixir
RUN apk -U upgrade && \
    apk --update --no-cache add ncurses-libs git make g++ wget python ca-certificates openssl nodejs nodejs-npm mysql-client imagemagick curl bash \
                     inotify-tools openssh && \
    update-ca-certificates --fresh && \
    npm install -g yarn brunch babel-brunch sass-brunch javascript-brunch css-brunch clean-css-brunch uglify-js-brunch && \
    rm -rf /var/cache/apk/*

# Add erlang-history
RUN git clone -q https://github.com/ferd/erlang-history.git && \
    cd erlang-history && \
    make install && \
    cd - && \
    rm -fR erlang-history

# Add local node module binaries to PATH
ENV PATH $PATH:node_modules/.bin:/root/.kiex/builds/elixir-git/bin

# Install Hex+Rebar
RUN mix local.hex --force && \
    mix local.rebar --force && \
    mix hex.info

EXPOSE 4000

CMD ["sh", "-c", "mix deps.get && mix phoenix.server"]
