#!/bin/bash

export PYENV_ROOT="/usr/local/pyenv"
export PATH="${PYENV_ROOT}/bin:${PATH}"
eval "$(pyenv init -)"

exec "$@"

# vim: ts=4 sts=4 sw=4 et ft=sh
