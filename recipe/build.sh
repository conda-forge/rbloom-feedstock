#!/bin/bash
set -ex

# Check if we are cross-compiling by trying to run the host python
if ! $PYTHON --version > /dev/null 2>&1; then
    echo "Cross-compiling detected: $PYTHON is not runnable."
    PYTHON_CMD="$BUILD_PREFIX/bin/python"
    # Use build python to install into host prefix
    $PYTHON_CMD -m pip install . -vv --no-deps --no-build-isolation --prefix "$PREFIX"
else
    $PYTHON -m pip install . -vv --no-deps --no-build-isolation
fi
