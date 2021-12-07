#!/bin/bash

OLDVERS=1.67.0
NEWVERS=1.74.0
BASEDIR="/lib/$(dpkg-architecture -qDEB_HOST_MULTIARCH)"

for L in filesystem system iostreams locale program-options thread
do
        LL=$(echo "${L}" | tr "-" "_")
	OLDPKGNAME="libboost-${L}${OLDVERS}"
	OLDLIBNAME="libboost_${LL}.so.${OLDVERS}"
	NEWPKGNAME="libboost-${L}${NEWVERS}"
	NEWLIBNAME="libboost_${LL}.so.${NEWVERS}"
	rm -rf "${OLDPKGNAME}" && mkdir -p "${OLDPKGNAME}/DEBIAN"
	cat > "${OLDPKGNAME}/DEBIAN/control" << EOF 
Section: misc
Priority: optional
Standards-Version: 3.9.2
Package: ${OLDPKGNAME}
Version: ${OLDVERS}-1
Architecture: all
Maintainer: Dario Nicodemi
Depends: ${NEWPKGNAME} (>= ${NEWVERS})
Description: compat symlink ${FROMVERS} -> ${TOVERS}
EOF
	cat > "${OLDPKGNAME}/DEBIAN/postinst" << EOF
#!/bin/sh
(cd "/lib/\$(dpkg-architecture -qDEB_HOST_MULTIARCH)" && ln -sf "${NEWLIBNAME}" "${OLDLIBNAME}")
EOF
	chmod 0755 "${OLDPKGNAME}/DEBIAN/postinst"
	cat > "${OLDPKGNAME}/DEBIAN/prerm" << EOF
#!/bin/sh
(cd "/lib/\$(dpkg-architecture -qDEB_HOST_MULTIARCH)" && rm "${OLDLIBNAME}")
EOF
	chmod 0755 "${OLDPKGNAME}/DEBIAN/prerm"
        dpkg-deb --build "${OLDPKGNAME}"
done

