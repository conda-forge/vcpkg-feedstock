OS=$(uname)
if [[ "$OS" = "Linux" || "$OS" = "Darwin" ]]; then
    LIBRARY_PREFIX="$PREFIX"
else
    LIBRARY_PREFIX="$PREFIX/Library"
fi
mkdir -p $LIBRARY_PREFIX/share/vcpkg

mv $SRC_DIR/ports $LIBRARY_PREFIX/share/vcpkg/
mv $SRC_DIR/scripts $LIBRARY_PREFIX/share/vcpkg/
mv $SRC_DIR/triplets $LIBRARY_PREFIX/share/vcpkg/
mv $SRC_DIR/versions $LIBRARY_PREFIX/share/vcpkg/
cp $SRC_DIR/.vcpkg-root $LIBRARY_PREFIX/share/vcpkg/.vcpkg-root
cp $SRC_DIR/LICENSE.txt $LIBRARY_PREFIX/share/vcpkg/LICENSE.txt

# Copy the [de]activate scripts to $PREFIX/etc/conda/[de]activate.d.
# This will allow them to be run on environment activation.
for CHANGE in "activate" "deactivate"
do
    mkdir -p "${PREFIX}/etc/conda/${CHANGE}.d"
    cp "${RECIPE_DIR}/${CHANGE}.sh" "${PREFIX}/etc/conda/${CHANGE}.d/${PKG_NAME}_${CHANGE}.sh"
done