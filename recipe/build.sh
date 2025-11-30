#!/bin/bash
set -ex

echo "CONDA_BUILD_CROSS_COMPILATION=${CONDA_BUILD_CROSS_COMPILATION:-}"
echo "target_platform=${target_platform:-}"
echo "build_platform=${build_platform:-}"
echo "uname -m=$(uname -m)"
echo "PYTHON=${PYTHON}"
echo "Which python: $(which python)"

# Check if we can run the host python
if $PYTHON --version > /dev/null 2>&1; then
    echo "Host python is runnable. Using it."
    $PYTHON -m pip install . -vv --no-deps --no-build-isolation
else
    echo "Host python is NOT runnable. Cross-compiling."
    # Fallback to 'python' in PATH, which should be the build python
    # We point pip to install into the target prefix
    python -m pip install . -vv --no-deps --no-build-isolation --prefix "$PREFIX"
fi
