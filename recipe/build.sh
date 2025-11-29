#!/bin/bash
set -ex

echo "CONDA_BUILD_CROSS_COMPILATION=${CONDA_BUILD_CROSS_COMPILATION:-}"
echo "target_platform=${target_platform:-}"
echo "build_platform=${build_platform:-}"
echo "uname -m=$(uname -m)"

IS_CROSS=0
if [[ "${CONDA_BUILD_CROSS_COMPILATION:-}" == "1" ]]; then
  IS_CROSS=1
elif [[ "$target_platform" == "osx-arm64" && "$(uname -m)" == "x86_64" ]]; then
  IS_CROSS=1
fi

if [[ "$IS_CROSS" == "1" ]]; then
  echo "Cross-compiling detected."
  # Use build python to drive installation
  # We point pip to install into the target prefix
  # We use 'python' from PATH which should be the build python (from requirements: build)
  python -m pip install . -vv --no-deps --no-build-isolation --prefix "$PREFIX"
else
  # Native build
  $PYTHON -m pip install . -vv --no-deps --no-build-isolation
fi
