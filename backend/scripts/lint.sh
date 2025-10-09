#!/usr/bin/env bash

set -e
set -x

mypy app
ruff check app --unsafe-fixes --preview
ruff format app --check --preview
