#!/bin/bash

# AutoNFS v1.5.1 Tests

# (c) 2012-2020 by viafintech GmbH
# Licensed under the MIT License

testAutoNFSDefaultParameters() {
  # Load AutoNFS defaults for testing
  . etc/default/autonfs

  echo -e "\033[35mExecuting 9 Assert-Tests...\033[0m"

  echo -e "-> \033[34mChecking default SCRIPTPATH...\033[0m"
  assertTrue 'Check default SCRIPTPATH' "[ '${SCRIPTPATH}' == '/usr/local/bin/autonfs.sh' ]"

  echo -e "-> \033[34mCheck valid LOGLEVEL values...\033[0m"
  assertTrue 'Check valid LOGLEVEL values' "[ $LOGLEVEL -ge 0 -a $LOGLEVEL -le 2 ]"

  echo -e "-> \033[34mCheck that FILESERVER is not empty...\033[0m"
  assertTrue 'Check that FILESERVER is not empty' "[[ -n $FILESERVER ]]"

  echo -e "-> \033[34mCheck valid NFSVERS values...\033[0m"
  assertTrue 'Check valid NFSVERS values' "[ $NFSVERS -ge 2 -a $NFSVERS -le 4 ]"

  echo -e "-> \033[34mCheck default MOUNTOPT parameter...\033[0m"
  assertTrue 'Check default MOUNTOPT parameter' "[ '${MOUNTOPT}' == '-o rw,hard,intr,tcp,actimeo=3' ]"

  echo -e "-> \033[34mCheck that INTERVAL is a valid number...\033[0m"
  assertTrue 'Check that INTERVAL is a valid number' "[[ ${INTERVAL} =~ ^[0-9]+$ ]]"

  echo -e "-> \033[34mCheck that MOUNTS is not empty...\033[0m"
  assertTrue 'Check that MOUNTS is not empty' "[ ${#MOUNTS[@]} -ne 0 ]"

  echo -e "-> \033[34mCheck the default MOUNTSDELIMITER...\033[0m"
  assertTrue 'Check the default MOUNTSDELIMITER' "[ '${MOUNTSDELIMITER}' == '|' ]"

  echo -e "-> \033[34mCheck that ANFSDEP is not empty...\033[0m"
  assertTrue 'Check that ANFSDEP is not empty' "[ ${#ANFSDEP[@]} -ne 0 ]"
}

. shunit2-2.1.6/src/shunit2
