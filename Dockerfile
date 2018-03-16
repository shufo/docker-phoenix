FROM elixir:1.6.3-alpine
MAINTAINER shufo


ENV REFRESHED_AT 2018-03-16
ENV ELIXIR_VERSION 1.6.3
ENV HOME /root

# Install Erlang/Elixir
RUN apk -U upgrade && \
    apk --update --no-cache add ncurses-libs git make g++ wget python ca-certificates openssl nodejs nodejs-npm mysql-client imagemagick curl bash \
                     inotify-tools openssh && \
    update-ca-certificates --fresh && \
    npm install -g yarn && \
    yarn global add brunch babel-brunch sass-brunch javascript-brunch css-brunch clean-css-brunch uglify-js-brunch && \
    rm -rf /var/cache/apk/* && \
    npm cache clean --force && \
    yarn cache clean

# Add erlang-history
RUN git clone -q https://github.com/ferd/erlang-history.git && \
    cd erlang-history && \
    make install && \
    cd - && \
    rm -fR erlang-history

# Add local node module binaries to PATH
ENV PATH $PATH:node_modules/.bin:/usr/local/bin

# Install Hex+Rebar
RUN mix local.hex --force && \
    mix local.rebar --force && \
    mix hex.info

EXPOSE 4000

CMD ["sh", "-c", "mix deps.get && mix phx.server"]
