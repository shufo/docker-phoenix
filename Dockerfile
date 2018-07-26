FROM erlang:21-alpine
MAINTAINER shufo

# elixir expects utf8.
ENV ELIXIR_VERSION="v1.7.0" \
	LANG=C.UTF-8

RUN set -xe \
	&& ELIXIR_DOWNLOAD_URL="https://github.com/elixir-lang/elixir/releases/download/${ELIXIR_VERSION}/Precompiled.zip" \
	&& ELIXIR_DOWNLOAD_SHA256="d6a84726a042407110d3b13b1ce8d9524b4a50df68174e79d89a9e42e30b410b" \
	&& buildDeps=' \
		ca-certificates \
		curl \
		unzip \
	' \
	&& apk add --no-cache --virtual .build-deps $buildDeps \
	&& curl -fSL -o elixir-precompiled.zip $ELIXIR_DOWNLOAD_URL \
	&& echo "$ELIXIR_DOWNLOAD_SHA256  elixir-precompiled.zip" | sha256sum -c - \
	&& unzip -d /usr/local elixir-precompiled.zip \
	&& rm elixir-precompiled.zip \
	&& apk del .build-deps

# Install dependencies
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
