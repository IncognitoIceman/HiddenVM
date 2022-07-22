#!/bin/bash

# Copyright (C) 2022 HiddenVM <https://github.com/IncognitoIceman/HiddenVM>
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <https://www.gnu.org/licenses/>.


set -e

. "/home/amnesia/.clearnet-vmanager/common.sh"
. "${CLEARNET_VMANAGER_ENV_FILE}"

HVM_ENV_ICON_NOTIFICATION="/home/amnesia/.local/share/icons/hiddenvm-icon-notification.svg"

enforce_amnesia
TIMESTAMP_VMANAGER_LOGS=$(date)

# Self log to file from this point on
VMANAGER_LAUNCH_LOG_FILE="${HVM_HOME}/logs/clearnet-vmanager_${TIMESTAMP_VMANAGER_LOGS}.log"
exec &> >(tee "${VMANAGER_LAUNCH_LOG_FILE}")

log "HiddenVM v${HVM_VERSION}"

log "Reached clearnet-vmanager.sh file"

# Prevent running multiple instances of this script
CMD="$(basename "${0}")"
exec 9>"/var/lock/${CMD}"
if ! flock -x -n 9; then
    error "Another instance of ${CMD} is already running"
    warn_box "HiddenVM" \
        "HiddenVM clearnet Virtual Machine Manager is already running! If you've just closed it, please wait a few more moments for the shutdown to complete and try again." "Warning"
    exit 1
fi

# Launches Virtual Machine Manager as the clearnet user with access to amnesia's display
launch_vmanager() {
    log "Launch Virtual Machine Manager as the clearnet user"
    xhost "+si:localuser:clearnet"
    sudo --non-interactive -u clearnet virt-manager --connect qemu:///session || true # Ignore on failure
    sleep 3
    xhost "-si:localuser:clearnet"
}

# Make sure the HiddenVM home is there (maybe the user ejected the drive)
if [ ! -d "${HVM_HOME}" ]; then
    error "Can't find HiddenVM home: ${HVM_HOME}"
    error_box "HiddenVM" "Can't find <b><i>${HVM_HOME}</i></b>\n\nThis can happen if you renamed, moved or deleted that folder, or if you unmounted the volume where it exists. To fix this, you can either undo that action or re-run the installer to select a different folder." "Error"
    exit 1
fi

# Create a FUSE userspace mount, forcing file ownership by clearnet. Note that
# the true owner of newly created files within the target will be the mounter
# (amnesia). Only attempt to mount if not already mounted.
if ! findmnt "${CLEARNET_HVM_MOUNT}"; then
    log "Mount ${CLEARNET_HVM_MOUNT}"
    bindfs -u clearnet --resolve-symlinks "${HVM_HOME}" "${CLEARNET_HVM_MOUNT}"
else
    log "Mount point ${CLEARNET_HVM_MOUNT} already exists!"
fi

launch_vmanager

log "Completing tear down"

# As the launch commmand doesn't hold the terminal we have to create a while loop to run till virt-manager is operational
CHECK_CMD1="pgrep -u clearnet -c -x virt-manager"
CHECK_CMD2=0
while GUI_ACTIVE=$(${CHECK_CMD1}); do
    CHECK_CMD2=1
done

notify-send -i dialog-warning \
    "HiddenVM is shutting down" \
    "Please wait before launching it again or ejecting the volume"
    
    log "Hidden VM is shutting down"

# Lazily unmount (in case the file system is busy)
if findmnt "${CLEARNET_HVM_MOUNT}"; then
    log "Lazily unmount ${CLEARNET_HVM_MOUNT}"
    fusermount -u -z "${CLEARNET_HVM_MOUNT}"
    sleep 3
else
    log "Did not find mount point to unmount: ${CLEARNET_HVM_MOUNT}"
fi

notify-send -i ${HVM_ENV_ICON_NOTIFICATION} \
    "HiddenVM was successfully shut down" \
    "You can re-launch it in GNOME or eject the volume"
    
    log "Hidden VM was shutdown"
