# Docker image for Python testing

## Introduction

This repository contains various Dockerfiles for building Python test images based on different Linux distributions. The Dockerfiles
install the CPython versions `2.6`, `2.7`, `3.0`, `3.1`, `3.2`, `3.3`, `3.4`, `3.5`, `3.6` and `3.7beta`. `Tox` can be
used to test against the complete set or a subset of these versions. Currently, this repository contains Dockerfiles
based on Alpine (latest), Debian stretch, Debian buster, Ubuntu 16.04 LTS and CentOS 7.

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
- `sciapp/python-testing:latest-debian` (alias for `sciapp/python-testing:latest-debian-stretch`)
- `sciapp/python-testing:latest-debian-stretch`
- `sciapp/python-testing:latest-debian-buster`
- `sciapp/python-testing:latest-ubuntu` (alias for `sciapp/python-testing:latest-ubuntu-16.04`)
- `sciapp/python-testing:latest-ubuntu-16.04`
- `sciapp/python-testing:latest-centos` (alias for `sciapp/python-testing:latest-centos-7`)
- `sciapp/python-testing:latest-centos-7` 
