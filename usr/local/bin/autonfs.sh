#!/bin/bash

# AutoNFS v1.2.2

# (c) 2012/2013 by Martin Seener (martin@seener.de)
# Licensed under the GPLv2

# Code can be found at github.com/martinseener/autonfs
# Original Idea from JeroenHoek at http://ubuntuforums.org/showthread.php?t=1389291

# Hints:
#   - only limited logging is active; for debug logging, uncomment all "logger" lines

# The hostname or IP-address of the fileserver:
FILESERVER="nfsserver.example.com"
# The NFS Version to be checked (must given to prevent "unknown version" syslog warnings)
NFSVERS=3
# Mount Options (see mount man pages for info)
MOUNTOPT="-o rw,hard,intr,tcp,actimeo=3"
# Check every X seconds (60 is a good default):
INTERVAL=60
# The shares that need to be mounted:
MOUNTS=( "/mnt/share" )

# Write PID to a PIDFILE for later process kill
# The init script handles the kill process and if there`s already a process running
echo $$ > /var/run/autonfs.pid

while true; do
  # First check if Fileserver is serving NFS
  /usr/bin/rpcinfo -t "$FILESERVER" nfs $NFSVERS &>/dev/null
  if [ $? -ne 0 ]; then
    # First check failed, therefore doing it twice after a second
    logger -t autonfs "Fileserver[${FILESERVER}] seems to be down - Rechecking in a second"
    sleep 1
    /usr/bin/rpcinfo -t "$FILESERVER" nfs $NFSVERS &>/dev/null
    if [ $? -eq 0 ]; then
      # Second check was succssful, checking if all NFS Shares are mounted
      logger -t autonfs "Fileserver[${FILESERVER}] is up"
      for MOUNT in ${MOUNTS[@]}; do
        mount | grep -E "^${FILESERVER}:${MOUNT} on .*$" &>/dev/null
        if [ $? -ne 0 ]; then
          # The actual NFS Share is not mounted, so it will be done now
          #logger -t autonfs "NFS-Share[${MOUNT}] not mounted - attempting to mount it from: ${FILESERVER}:${MOUNT}"
          mount -t nfs ${MOUNTOPT} ${FILESERVER}:${MOUNT} ${MOUNT}
        fi
      done
    else
      # The Fileserver was not reachable two times, unmounting shares which are still mounted
      logger -t autonfs "Fileserver(${FILESERVER}) is down."
      for MOUNT in ${MOUNTS[@]}; do
        mount | grep -E "^${FILESERVER}:${MOUNT} on .*$" &>/dev/null
        if [ $? -eq 0 ]; then
          logger -t autonfs "Cannot reach ${FILESERVER}, therefore unmounting NFS-Share[${MOUNT}]"
          umount -f ${MOUNT}
        fi
      done
    fi
  else
    # First check succeeded, so just checking if all NFS-Shares are mounted
    #logger -t autonfs "Fileserver[${FILESERVER}] is up"
    for MOUNT in ${MOUNTS[@]}; do
      mount | grep -E "^${FILESERVER}:${MOUNT} on .*$" &>/dev/null
      if [ $? -ne 0 ]; then
        # The actual NFS Share is not mounted, so it will be done now
        #logger -t autonfs "NFS-Share[${MOUNT}] not mounted - attempting to mount it from: ${FILESERVER}:${MOUNT}"
        mount -t nfs ${MOUNTOPT} ${FILESERVER}:${MOUNT} ${MOUNT}
      fi
    done
  fi
  # Gone through the check iteration - sleeping now for a while
  sleep $INTERVAL
done
