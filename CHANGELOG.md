# AutoNFS Changelog

AutoNFS is a client-side autofs-free NFS Share Automount-Script, initially designed for Debian Squeeze or derivates.
The Code can be found at [https://github.com/martinseener/autonfs](https://github.com/martinseener/autonfs)

## v1.3
- Fixed small typo in CHANGELOG.md
- Changed autonfs.sh and autonfs init script from #!/bin/bash to #!/usr/bin/env bash for portability purposes
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