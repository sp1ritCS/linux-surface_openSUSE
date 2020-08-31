#!/bin/bash
PKGNAME="${PKGNAME:=kernel-surface}"
PROJECT="${PROJECT:=home:sp1rit:surface}"
SPECROOT="${SPECROOT:=$BUILDROOT/kernel-surface}"
PKGROOT="${PKGROOT:=$PWD/kernel-surface-$(cat /proc/sys/kernel/random/uuid)}"

set -e
mkdir -p "$PKGROOT"
cd "$PKGROOT"

# Get existing package
osc co "$PROJECT" "$PKGNAME"

# Remove existing files
rm -f "$PKGROOT/$PROJECT/$PKGNAME"/*

# Copy new files
cp "$SPECROOT"/* "$PKGROOT/$PROJECT/$PKGNAME"

# Upload
cd "$PKGROOT/$PROJECT/$PKGNAME"
#osc ci
