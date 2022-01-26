mkdir -p $PREFIX/share/vcpkg

mv $SRC_DIR/ports $PREFIX/share/vcpkg/
mv $SRC_DIR/scripts $PREFIX/share/vcpkg/
mv $SRC_DIR/triplets $PREFIX/share/vcpkg/
mv $SRC_DIR/versions $PREFIX/share/vcpkg/
cp $SRC_DIR/.vcpkg-root $PREFIX/share/vcpkg/.vcpkg-root

# Copy the [de]activate scripts to $PREFIX/etc/conda/[de]activate.d.
# This will allow them to be run on environment activation.
for CHANGE in "activate" "deactivate"
do
    mkdir -p "${PREFIX}/etc/conda/${CHANGE}.d"
    cp "${RECIPE_DIR}/${CHANGE}.sh" "${PREFIX}/etc/conda/${CHANGE}.d/${PKG_NAME}_${CHANGE}.sh"
done