# AutoNFS Changelog

AutoNFS is a client-side autofs-free NFS Share Automount-Script, initially designed for Debian Squeeze or derivates.
The Code can be found at [https://github.com/martinseener/autonfs](https://github.com/martinseener/autonfs)

## v1.4
- Removed Roadmap from README - we have Github for this
- made autonfs SysVinit script conform with 2-space indentation ([fixes #5](https://github.com/martinseener/autonfs/issues/5))
- Changed AutoNFS main script shabang to bash since we use this in the script as well (may be changed later to sh)
- Added functionality to have different remote and local mountpoints ([fixes #1](https://github.com/martinseener/autonfs/issues/1))
- Created OS subfolders to have the right init/upstart scripts for the right distribution where you can use AutoNFS (currently SysVinit and Upstart)

## v1.3
- Fixed small typo in CHANGELOG.md
- Changed autonfs.sh and autonfs init script from #!/bin/bash|#!/bin/sh to #!/usr/bin/env bash|#!/usr/bin/env sh for portability purposes
- AutoNFS now uses a separate configuration file at /etc/default/autonfs for easier maintenance (autonfs.sh location is now completely user configurable)

### v1.2.2
- Moved Changelog from inline comments to separate markdown file

### v1.2.1
- Logging is only done when something is not working in first place (limited logging)

## v1.2
- Improved NFS Server check (double checks if N/A before unmounting)
- Sometimes the first check is a false positive, therefore doing two with a one second delay
- Improved debug syslogging (added a tag and more useful information)
- Added some more inline comments for explanation

## v1.1
- Added `NFSVERS` parameter which prevents the server from writing "unkown version" warnings into syslog for each call

## v1.0
- Intitial Version