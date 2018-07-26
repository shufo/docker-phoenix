# docker-phoenix

This repository contains a script for create [phoenix](http://www.phoenixframework.org/) server image.
DockerHub repository is [here](https://hub.docker.com/r/shufo/phoenix/)

You can use these tags as a version of elixir.

- `1.7.0`, `latest`
- `1.7.0-development`
- `1.6.6`
- `1.6.6-development`
- `1.6.5`
- `1.6.5-development`
- `1.6.4`
- `1.6.4-development`
- `1.6.3`
- `1.6.3-development`
- `1.6.2`
- `1.6.2-development`
- `1.6.1`
- `1.6.1-development`
- `1.6.0`
- `1.6.0-development`
- `1.5.2`
- `1.5.2-development`
- `1.5.1`
- `1.5.1-development`
- `1.5.0`
- `1.5.0-development`
- `1.4.5`
- `1.4.5-development`
- `1.4.4`
- `1.4.4-development`
- `1.4.3`
- `1.4.3-development`
- `1.4.2`
- `1.4.2-development`
- `1.4.1`
- `1.4.1-development`
- `1.4.0`
- `1.4.0-development`
- `1.4.0-rc.1`
- `1.4.0-rc.1-development`
- `1.4.0-rc.0`
- `1.3.4`
- `1.3.4-development`
- `1.3.3`
- `1.3.2`
- `1.3.1`
- `1.3.0`
- `1.2.6`
- `1.2.5`
- `1.2.3`

`development` tags are including node.js and utilities to automatically compile assets on development environment.

## Usage

Run below command in your phoenix project directory.

```
docker run -d -p 4000:4000 -v $(pwd):/app -w /app shufo/phoenix
```

### docker-compose


```
app:
  image: shufo/phoenix:1.6.1-development
  container_name: myproject_app
  hostname: app
  expose:
    - 4000
  ports:
    - "4000:4000"
    - "4001:4001"
  working_dir: /code
  volumes:
    - ".:/code"
  environment:
    - "PORT=4000"
    - "ERL_AFLAGS=-kernel shell_history enabled"
  links:
    - mysql
```
