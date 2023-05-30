# Docker image for Python testing

## Introduction

This repository contains various Dockerfiles for building Python test images based on different Linux distributions. The
Dockerfiles install the CPython versions `2.7`, `3.0`, `3.1`, `3.2`, `3.3`, `3.4`, `3.5`, `3.6`, `3.7`, `3.8`,`3.9`,
`3.10` and `3.11` (depending on the Linux distribution some versions are not available).
[Tox](https://tox.readthedocs.io/en/latest/) is preinstalled and can be used to test against Python `2.7` and `3.3+`.
Currently, this repository contains Dockerfiles based on Alpine (latest), Debian buster and bullseye, Ubuntu 16.04,
18.04, 20.04 and 22.04 LTS, CentOS 7 and Rocky Linux 8.

## Available Python versions

- Alpine: `2.7`, `3.7`, `3.8`, `3.9`, `3.10`, `3.11`
- CentOS 7: `2.7`, `3.0`, `3.1`, `3.2`, `3.3`, `3.4`, `3.5`, `3.6`, `3.7`, `3.8`, `3.9`
- Rocky Linux 8: `2.7`, `3.5`, `3.6`, `3.7`, `3.8`, `3.9`, `3.10`, `3.11`
- Rocky Linux 9: `2.7`, `3.5`, `3.6`, `3.7`, `3.8`, `3.9`, `3.10`, `3.11`
- Debian buster: `2.7`, `3.5`, `3.6`, `3.7`, `3.8`, `3.9`, `3.10`, `3.11`
- Debian bullseye: `2.7`, `3.5`, `3.6`, `3.7`, `3.8`, `3.9`, `3.10`, `3.11`
- Ubuntu 16.04: `2.7`, `3.0`, `3.1`, `3.2`, `3.3`, `3.4`, `3.5`, `3.6`, `3.7`, `3.8`, `3.9`
- Ubuntu 18.04: `2.7`, `3.1`, `3.2`, `3.3`, `3.4`, `3.5`, `3.6`, `3.7`, `3.8`, `3.9`
- Ubuntu 20.04: `2.7`, `3.5`, `3.6`, `3.7`, `3.8`, `3.9`, `3.10`, `3.11`
- Ubuntu 22.04: `2.7`, `3.7`, `3.8`, `3.9`, `3.10`, `3.11`

## Usage with GitLab CI

Create a `.gitlab-ci.yml` configuration for your project that uses the `python-testing` image:

```yaml
stages:
  - test

test:
  image: sciapp/python-testing:latest
  stage: test
  script:
    - tox
```

`sciapp/python-testing:latest` is an alias for the Alpine image.

In order for this configuration to work, you need a
[Tox configuration file (`tox.ini`)](https://tox.readthedocs.io/en/latest/).

## List of available tags

- `sciapp/python-testing:latest` (alias for `sciapp/python-testing:latest-alpine`)
- `sciapp/python-testing:latest-alpine`
- `sciapp/python-testing:latest-debian` (alias for `sciapp/python-testing:latest-debian-bullseye`)
- `sciapp/python-testing:latest-debian-buster`
- `sciapp/python-testing:latest-debian-bullseye`
- `sciapp/python-testing:latest-ubuntu` (alias for `sciapp/python-testing:latest-ubuntu-22.04`)
- `sciapp/python-testing:latest-ubuntu-16.04`
- `sciapp/python-testing:latest-ubuntu-18.04`
- `sciapp/python-testing:latest-ubuntu-20.04`
- `sciapp/python-testing:latest-ubuntu-22.04`
- `sciapp/python-testing:latest-rocky` (alias for `sciapp/python-testing:latest-rocky-9`)
- `sciapp/python-testing:latest-centos-7`
- `sciapp/python-testing:latest-rocky-8`
- `sciapp/python-testing:latest-rocky-9`
