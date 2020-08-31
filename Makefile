# Make kernel-surface.

UUID = 1842dc7d-c526-4cc7-96f6-73155cbf06fd
BUILDROOT = $(PWD)/surface-opensuse-$(UUID)
PKGROOT = $(PWD)/kernel-surface-$(UUID)
PROJ = home:sp1rit:surface
PKGNAME = kernel-surface
KVERSION = 5.8
ARCH = x86_64
REPOURI = git@github.com:linux-surface/linux-surface.git


all:
	make generate

clean:
	rm -rf surface-opensuse-* kernel-surface-*
	
generate:
	PKGNAME="$(PKGNAME)" KVERSION="$(KVERSION)" ARCH="$(ARCH)" REPOURI="$(REPOURI)" BUILDROOT="$(BUILDROOT)" bash mkspec.sh
	
upload:
	PKGNAME="$(PKGNAME)" PROJECT="$(PROJ)" BUILDROOT="$(BUILDROOT)" PKGROOT="$(PKGROOT)" bash upl_buildservice.sh
