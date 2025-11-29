#!/bin/bash
set -ex

if [[ "${CONDA_BUILD_CROSS_COMPILATION:-}" == "1" ]]; then
  echo "Cross-compiling detected."
  # Use build python to drive installation
  # We point pip to install into the target prefix
  $BUILD_PREFIX/bin/python -m pip install . -vv --no-deps --no-build-isolation --prefix "$PREFIX"
else
  # Native build
  $PYTHON -m pip install . -vv --no-deps --no-build-isolation
fi
