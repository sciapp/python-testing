FROM ubuntu:16.04 as builder
LABEL maintainer="Ingo Heimbach <i.heimbach@fz-juelich.de>"

ENV PYENV_ROOT "/usr/local/pyenv"
ENV PATH "${PYENV_ROOT}/bin:${PYENV_ROOT}/shims:${PATH}"
ENV LANG C.UTF-8

RUN apt-get update && \
    apt-get install -y --no-install-recommends build-essential \
                                               ca-certificates \
                                               curl \
                                               gawk \
                                               git \
                                               libbz2-dev \
                                               libffi-dev \
                                               liblzma-dev \
                                               libncursesw5-dev \
                                               libreadline-dev \
                                               libsqlite3-dev \
                                               libssl-dev \
                                               zlib1g-dev && \
    rm -rf /var/lib/apt/lists/*

RUN latest_pyenv_version="$(git ls-remote https://github.com/pyenv/pyenv.git | awk '$2 ~ "^refs/tags/v[[:digit:]]+\\.[[:digit:]]+\\.[[:digit:]]+$" { print $2 }' | awk -F'/' '{ print substr($NF, 2) }' | sort -t. -k 1,1n -k 2,2n -k 3,3n | tail -1)" && \
    curl -o "/tmp/v${latest_pyenv_version}.tar.gz" -L "https://github.com/pyenv/pyenv/archive/v${latest_pyenv_version}.tar.gz" && \
    tar -C /tmp/ -xvf "/tmp/v${latest_pyenv_version}.tar.gz" && \
    mv "/tmp/pyenv-${latest_pyenv_version}" "${PYENV_ROOT}"

RUN if [ ! -d "${PYENV_ROOT}/plugins/python-build/share/python-build/patches/3.3.7" ]; then \
        cp -r "${PYENV_ROOT}/plugins/python-build/share/python-build/patches/3.3.6" "${PYENV_ROOT}/plugins/python-build/share/python-build/patches/3.3.7" && \
        mv "${PYENV_ROOT}/plugins/python-build/share/python-build/patches/3.3.7/Python-3.3.6" "${PYENV_ROOT}/plugins/python-build/share/python-build/patches/3.3.7/Python-3.3.7"; \
    fi

RUN set -e; \
    installed_python_versions=""; \
    for version in 2.6 2.7 3.0 3.1 3.2 3.3 3.4 3.5 3.6 3.7 3.8 3.9; do \
        latest_version="$(pyenv install --list | awk "NR > 1 && \$1 ~ /^${version}[0-9.]*(-dev)?$/" | tail -1 | tr -d ' ')"; \
        pyenv install "${latest_version}"; \
        installed_python_versions="${latest_version} ${installed_python_versions}"; \
    done; \
    pyenv global ${installed_python_versions}

RUN pip install -U pip && \
    pip install tox

FROM ubuntu:16.04

ENV PYENV_ROOT "/usr/local/pyenv"
ENV PATH "${PYENV_ROOT}/bin:${PYENV_ROOT}/shims:${PATH}"

RUN apt-get update && \
    apt-get install -y --no-install-recommends ca-certificates \
                                               libbz2-1.0 \
                                               libffi6 \
                                               liblzma5 \
                                               libncursesw5 \
                                               libreadline6 \
                                               libsqlite3-0 \
                                               libssl1.0.0 \
                                               zlib1g && \
    rm -rf /var/lib/apt/lists/*

COPY --from=builder "${PYENV_ROOT}" "${PYENV_ROOT}"
COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh

ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]
CMD ["/bin/bash"]
