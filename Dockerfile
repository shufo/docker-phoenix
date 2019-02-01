FROM erlang:21-alpine

# elixir expects utf8.
ENV ELIXIR_VERSION="v1.8.0" \
	LANG=C.UTF-8

# Install dependencies
RUN apk -U upgrade && \
    apk --update --no-cache add ncurses-libs git make g++ wget python ca-certificates openssl curl && \
    update-ca-certificates --fresh && \
    rm -rf /var/cache/apk/*

RUN set -xe \
	&& ELIXIR_DOWNLOAD_URL="https://github.com/elixir-lang/elixir/archive/${ELIXIR_VERSION}.tar.gz" \
	&& ELIXIR_DOWNLOAD_SHA256="fe896d8b2914f982d2e6fceeb585f59a8f92ad872653fc46c13df9ff86d69234" \
	&& curl -fSL -o elixir-src.tar.gz $ELIXIR_DOWNLOAD_URL \
	&& echo "$ELIXIR_DOWNLOAD_SHA256  elixir-src.tar.gz" | sha256sum -c - \
	&& mkdir -p /usr/local/src/elixir \
	&& tar -xzC /usr/local/src/elixir --strip-components=1 -f elixir-src.tar.gz \
	&& rm elixir-src.tar.gz \
	&& cd /usr/local/src/elixir \
	&& make install clean

# Add local node module binaries to PATH
ENV PATH $PATH:node_modules/.bin:/usr/local/bin

# Install Hex+Rebar
RUN mix local.hex --force && \
    mix local.rebar --force && \
    mix hex.info

EXPOSE 4000

CMD ["sh", "-c", "mix deps.get && mix phoenix.server"]
