FROM alpine:latest as builder
LABEL maintainer="Ingo Heimbach <i.heimbach@fz-juelich.de>"

RUN apk --no-cache add bash \
                       build-base \
                       bzip2-dev \
                       ca-certificates \
                       curl \
                       git \
                       linux-headers \
                       openssl-dev \
                       ncurses-dev \
                       patch \
                       readline-dev \
                       sqlite-dev \
                       xz-dev \
                       zlib-dev

ENV PYENV_ROOT "/usr/local/pyenv"
ENV PATH "${PYENV_ROOT}/bin:${PYENV_ROOT}/shims:${PATH}"

RUN latest_pyenv_version="$(git ls-remote https://github.com/pyenv/pyenv.git | awk '$2 ~ "^refs/tags/v[[:digit:]]+\\.[[:digit:]]+\\.[[:digit:]]+$" { print $2 }' | awk -F'/' '{ print substr($NF, 2) }' | sort -t. -k 1,1n -k 2,2n -k 3,3n | tail -1)" && \
    curl -o "/tmp/v${latest_pyenv_version}.tar.gz" -L "https://github.com/pyenv/pyenv/archive/v${latest_pyenv_version}.tar.gz" && \
    tar -C /tmp/ -xvf "/tmp/v${latest_pyenv_version}.tar.gz" && \
    mv "/tmp/pyenv-${latest_pyenv_version}" "${PYENV_ROOT}"

COPY patches /tmp/patches

RUN set -e; \
    for version in 2.6 2.7 3.0 3.1 3.2 3.3 3.4 3.5 3.6; do \
        latest_version="$(pyenv install --list | awk "NR > 1 && \$1 ~ /^${version}[0-9.]*$/" | tail -1 | tr -d ' ')"; \
        if [ -f "/tmp/patches/posix_close_${version}.patch" ]; then \
            pyenv install --patch "${latest_version}" < "/tmp/patches/posix_close_${version}.patch"; \
        else \
            pyenv install "${latest_version}"; \
        fi; \
        pyenv global "${latest_version}"; \
    done

RUN pip install -U pip && \
    pip install tox

FROM alpine:latest

RUN apk --no-cache add bash \
                       bzip2 \
                       ca-certificates \
                       openssl \
                       ncurses \
                       readline \
                       sqlite \
                       xz \
                       zlib

COPY --from=builder "${PYENV_ROOT}" "${PYENV_ROOT}"
COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh

ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]
CMD ["/bin/bash"]
