# libboost1.67.0-debian11
Compatibility packages for programs requiring boost 1.67.0 in bullseye.

Debian 11 Bullseye comes with version 1.74.0 of libboost, whereas Debian 10 Buster shipped 1.67.0. These packages create symlinks to boost 1.74.0 for backwards compatibility.

To generate the .deb packages, run:

```bash
./genpkg.sh
```
The script writes the packages into the directory ``target/libboost1.67.0-debian11-1.67.0-1``, and generates tarball.

To install the packages:
```bash
cd target/libboost1.67.0-debian11-1.67.0-1
dpkg -i *.deb
```
