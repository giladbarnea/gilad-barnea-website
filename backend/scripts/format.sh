#!/bin/sh -e
set -x

ruff check app scripts --fix --unsafe-fixes --preview
ruff format app scripts --preview
