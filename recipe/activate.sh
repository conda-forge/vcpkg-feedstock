OS=$(uname)
if [[ "$OS" = "Linux" || "$OS" = "Darwin" ]]; then
    LIBRARY_PREFIX="$PREFIX"
else
    LIBRARY_PREFIX="$PREFIX/Library"
fi
export VCPKG_ROOT=${LIBRARY_PREFIX}/share/vcpkg/
