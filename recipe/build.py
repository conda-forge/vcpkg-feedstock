import os
import shutil
from pathlib import Path


PREFIX = Path(os.environ["PREFIX"])
SRC_DIR = Path(os.environ["SRC_DIR"])
RECIPE_DIR = Path(os.environ["RECIPE_DIR"])
PKG_NAME = os.environ["PKG_NAME"]
TARGET_PLATFORM = os.environ["target_platform"]
if TARGET_PLATFORM.lower().startswith("win"):
    LIBRARY_PREFIX = PREFIX / "Library"
else:
    LIBRARY_PREFIX = PREFIX
VCPKG_ROOT = LIBRARY_PREFIX / "share" / "vcpkg"

shutil.copytree(src=SRC_DIR/"ports", dst=VCPKG_ROOT/"ports")
shutil.copytree(src=SRC_DIR/"scripts", dst=VCPKG_ROOT/"scripts")
shutil.copytree(src=SRC_DIR/"triplets", dst=VCPKG_ROOT/"triplets")
shutil.copytree(src=SRC_DIR/"versions", dst=VCPKG_ROOT/"versions")
shutil.copy2(src=SRC_DIR/".vcpkg-root", dst=VCPKG_ROOT)
shutil.copy2(src=SRC_DIR/"LICENSE.txt", dst=VCPKG_ROOT)

# Copy the [de]activate scripts to $PREFIX/etc/conda/[de]activate.d.
# This will allow them to be run on environment activation.
for script in ["activate", "deactivate"]:
    dst = PREFIX/"etc"/"conda"/f"{script}.d"
    dst.mkdir(parents=True)
    shutil.copy2(src=RECIPE_DIR/f"{script}.sh", dst=dst/f"{PKG_NAME}_{script}.sh")
    if TARGET_PLATFORM.lower().startswith("win"):
        shutil.copy2(src=RECIPE_DIR/f"{script}.bat", dst=dst/f"{PKG_NAME}_{script}.bat")
