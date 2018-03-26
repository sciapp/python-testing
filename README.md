# Docker image for Python testing

## Introduction

This repository contains a Dockerfile for building a Python test image. The Dockerfile is based on Alpine Linux and
installs the CPython versions `2.6`, `2.7`, `3.0`, `3.1`, `3.2`, `3.3`, `3.4`, `3.5` and `3.6`. `Tox` can be used to
test against the complete set or a subset of these versions.

## Usage

Create a `.gitlab-ci.yml` configuration for your project that uses the `python-testing` image:

```yaml
stages:
  - test

test:
  image: iffregistry.fz-juelich.de/docker-images/python-testing:latest
  stage: test
  script:
    - tox
```

In order for this configuration to work, you need a 
[Tox configuration file (`tox.ini`)](https://tox.readthedocs.io/en/latest/).
