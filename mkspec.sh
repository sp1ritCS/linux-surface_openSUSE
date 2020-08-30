#!/bin/bashi
PKGNAME="kernel-surface"
KVERSION="5.8"
ARCH="x86_64"
REPOURI="git@github.com:linux-surface/linux-surface.git"
BUILDROOT="$PWD/surface-opensuse-$(cat /proc/sys/kernel/random/uuid)"

set -e
mkdir -p $BUILDROOT

# Get sources
cp surface.patch $BUILDROOT/
cd $BUILDROOT
osc co Kernel:stable kernel-default
git clone --depth 1 --no-checkout --filter="blob:none" "$REPOURI" "linux-surface" && cd linux-surface
git checkout master -- "patches/$KVERSION/" "configs/surface-$KVERSION.config"
cd $BUILDROOT

# Create patches
mkdir "$BUILDROOT/patches.surface"
cp "$BUILDROOT/linux-surface/patches/$KVERSION/"*.patch "$BUILDROOT/patches.surface/"
# Add patches to series.conf
cat <<EOF >> "$BUILDROOT/Kernel:stable/kernel-default/series.conf"

	########################################################
	# I do have a good reason to add a patch down here!
	# Surface patches
	########################################################
EOF
find "patches.surface/" -type f -printf "	%p\n" >> "$BUILDROOT/Kernel:stable/kernel-default/series.conf"
tar -cjf "$BUILDROOT/Kernel:stable/kernel-default/patches.surface.tar.bz2" "patches.surface"
rm -rf "$BUILDROOT/patches.surface"

# Create & merge configs
bzip2 -d "$BUILDROOT/Kernel:stable/kernel-default/config.tar.bz2" -c > "$BUILDROOT/config.tar"
mkdir -p "$BUILDROOT/config/$ARCH/"
cp "$BUILDROOT/linux-surface/configs/surface-$KVERSION.config" "$BUILDROOT/config/$ARCH/surface"
tar -rvf "$BUILDROOT/config.tar" "config"
bzip2 "$BUILDROOT/config.tar" -c > "$BUILDROOT/Kernel:stable/kernel-default/config.tar.bz2"
rm -rf "$BUILDROOT/config" "config.tar"

# Copy & patch specfile
cd "$BUILDROOT/Kernel:stable/kernel-default/"
cp kernel-default.spec "$PKGNAME.spec"
cat <<EOF > "$PKGNAME.changes"
-------------------------------------------------------------------
$(LANG=undef date) - $USER

- Added linux-surface patches & configs

EOF
cat kernel-default.changes >> "$PKGNAME.changes"
git apply "$BUILDROOT/surface.patch"
cd "$BUILDROOT"

# Rename kernel-default to $PKGNAME
mv "$BUILDROOT/Kernel:stable/kernel-default" "$BUILDROOT/$PKGNAME"
echo "linux-surface ➡ openSUSE package path is now ready to be build: $BUILDROOT/$PKGNAME"
