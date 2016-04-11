# docker-phoenix

This repository contains a script for create [phoenix](http://www.phoenixframework.org/) server image.
DockerHub repository is [here](https://hub.docker.com/r/shufo/phoenix/)

## Usage

Run below command in your phoenix project directory.

```
docker run -d -p 4000:4000 -v $(pwd):/app -w /app shufo/phoenix
```
