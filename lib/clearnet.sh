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


enforce_amnesia

setup_clearnet() {
    log "Configure clearnet user, prog-id=16"

    # Create the "HiddenVM" mount point within clearnet's home.
    # Note that mounting it is part the launcher script.
    sudo -u clearnet mkdir -p "${CLEARNET_HVM_MOUNT}"

    # Make sure the mount point is owned by the clearnet user and amnesia group.
    # It also needs to be readable and writable by the amnesia group, so that
    # amnesia can mount it later.
    sudo chown clearnet:amnesia "${CLEARNET_HVM_MOUNT}" || true # ignore failure (mount might be live)
    sudo chmod 775 "${CLEARNET_HVM_MOUNT}"

    # Set bash as the shell for the clearnet user. The Virtual Machine Manager application needs
    # this if, for example, the user (clearnet) installs the extension pack manually.
    sudo chsh -s /bin/bash clearnet

    # Add the clearnet user to the following groups:
    #   video:                    Virtual Machine Manager needs access to OpenGL drivers
    #   audio:                    Virtual Machine Manager needs access to the sound card via PulseAudio in Tails
    #   libvirt & libvirt-qemu:   Virtual Machine Manager needs to launch without needing root permissions everytime automatically to run libvirt and libvirt-qemu 
    #sudo usermod -a -G video,audio,vbboxusers clearnet
    sudo usermod -a -G video,audio,libvirt,libvirt-qemu,kvm clearnet

    # restart amnesia's pulseaudio server first, otherwise we get an error trying to start pulseaudio for clearnet below
    systemctl --user restart pulseaudio
    # start a pulseaudio server for clearnet to allow Virtual Machine Manager VMs to send sound through to Tails
    # (exit-idle-time=-1 prevents the pulseaudio daemon from exiting after the VMs are shut down)
    sudo -u clearnet pulseaudio --start --exit-idle-time=-1 --high-priority

    # Set up sudo access to execute the clearnet vmanager launcher as the clearnet user,
    # so that we can launch virtual machine manager from bootstrap without authenticating again.
    # IMPORTANT: sudo parses files in /etc/sudoers.d in lexical order. We want this
    # file to be parsed last to prevent others from overriding its settings, hence
    # all the z's in the beginning of the file name.
    local SUDOER_FILE_NAME="zzzzzzzzzz-hiddenvm-01-sudoer"
    # Copy to /tmp first because sudo can't access the file from within the AppImage mount
    cp "lib/assets/${SUDOER_FILE_NAME}" /tmp/
    sudo chown root:root "/tmp/${SUDOER_FILE_NAME}"
    sudo chmod 440 "/tmp/${SUDOER_FILE_NAME}"
    sudo mv "/tmp/${SUDOER_FILE_NAME}" /etc/sudoers.d/
}
