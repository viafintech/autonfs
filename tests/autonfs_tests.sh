#!/bin/bash

# AutoNFS v1.4.2 Tests

# (c) 2012-2014 by Martin Seener (martin@seener.de)
# Licensed under the GPLv2

oneTimeSetUp() {
  # Set HOMEDIR to the root of AutoNFS for all tests
  HOMEDIR=$PWD/..
}

testAutoNFSDefaultParameters() {
  # Load AutoNFS defaults for testing
  . $HOMEDIR/etc/default/autonfs

  assertTrue 'Check default SCRIPTPATH' "[ '${SCRIPTPATH}' == '/usr/local/bin/autonfs.sh' ]"
  assertTrue 'Check valid LOGLEVEL values' "[ $LOGLEVEL -ge 0 -a $LOGLEVEL -le 2 ]"
  assertTrue 'Check that FILESERVER is not empty' "[[ -n $FILESERVER ]]"
  assertTrue 'Check valid NFSVERS values' "[ $NFSVERS -ge 2 -a $NFSVERS -le 4 ]"
  assertTrue 'Check default MOUNTOPT parameter' "[ '${MOUNTOPT}' == '-o rw,hard,intr,tcp,actimeo=3' ]"
  assertTrue 'Check that INTERVAL is a valid number' "[[ ${INTERVAL} =~ ^[0-9]+$ ]]"
  assertTrue 'Check that MOUNTS is not empty' "[ ${#MOUNTS[@]} -ne 0 ]"
  assertTrue 'Check the default MOUNTSDELIMITER' "[ '${MOUNTSDELIMITER}' == '|' ]"
}

. src/shunit2
