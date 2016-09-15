# docker-phoenix

This repository contains a script for create [phoenix](http://www.phoenixframework.org/) server image.
DockerHub repository is [here](https://hub.docker.com/r/shufo/phoenix/)

These elixir versions can be used as a tag.

- `1.3.2`, `latest`
- `1.3.1`
- `1.3.0`
- `1.2.6`
- `1.2.5`
- `1.2.3`


## Usage

Run below command in your phoenix project directory.

```
docker run -d -p 4000:4000 -v $(pwd):/app -w /app shufo/phoenix
```
