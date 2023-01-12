OS=$(uname)
if [[ "$OS" = "Linux" || "$OS" = "Darwin" ]]; then
    LIBRARY_PREFIX="$CONDA_PREFIX"
else
    LIBRARY_PREFIX="$CONDA_PREFIX/Library"
fi
export VCPKG_ROOT=${LIBRARY_PREFIX}/share/vcpkg/
