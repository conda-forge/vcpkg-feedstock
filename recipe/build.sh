mkdir -p $PREFIX/Library/share/vcpkg

mv $SRC_DIR/ports $PREFIX/Library/share/vcpkg/
mv $SRC_DIR/scripts $PREFIX/Library/share/vcpkg/
mv $SRC_DIR/triplets $PREFIX/Library/share/vcpkg/
mv $SRC_DIR/versions $PREFIX/Library/share/vcpkg/
cp $SRC_DIR/.vcpkg-root $PREFIX/Library/share/vcpkg/.vcpkg-root
cp $SRC_DIR/LICENSE.txt $PREFIX/Library/share/vcpkg/LICENSE.txt

# Copy the [de]activate scripts to $PREFIX/etc/conda/[de]activate.d.
# This will allow them to be run on environment activation.
for CHANGE in "activate" "deactivate"
do
    mkdir -p "${PREFIX}/etc/conda/${CHANGE}.d"
    cp "${RECIPE_DIR}/${CHANGE}.sh" "${PREFIX}/etc/conda/${CHANGE}.d/${PKG_NAME}_${CHANGE}.sh"
done