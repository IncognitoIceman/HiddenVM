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

COUNT=100000
VMANAGER_DEFAULT_CONFIG_FILE_EXISTS=false

enforce_amnesia

# Checking if the storage pool exists by looking for the keyword active
get_active_pool_count() 
{
    COUNT=$(sudo -u clearnet virsh pool-list --all | sed -n 's/.*\(active\).*/\1/p'| grep -c "active")

    log "Currently there are ${COUNT} storage pool(s) which exist"

    return "${COUNT}"
}

# Makes the Virtual Machine Manager application's config persistent
setup_vmanager_persistent_config() {
    log "Set up Virtual Machine Manager persistent configuration, prog-id=17"

    # Ensure that the persistent Virtual Machine Manager application config and VM dirs exist
    local VMANAGER_CONFIG_CACHE_DIR="${HVM_HOME}/cache/config-vmanager/libvirt/storage"
    local VMANAGER_CONFIG_CACHE_DIR_ALL_FILES="${VMANAGER_CONFIG_CACHE_DIR}/."
    local VMANAGER_CONFIG_FILENAME="default.xml"
    local VMANAGER_CONFIG_FILENAME_EXISTS=false
    local HVM_HOME_VMANAGER_VM_LOCATION="${HVM_HOME}/Virtual Machine Manager VMs"
    local VMANAGER_DEFAULT_CONFIG_CACHE_FILE="${VMANAGER_CONFIG_CACHE_DIR}/${VMANAGER_CONFIG_FILENAME}"
    mkdir -p "${VMANAGER_CONFIG_CACHE_DIR}"
    mkdir -p "${HVM_HOME_VMANAGER_VM_LOCATION}"
    

    # Make the Virtual Machine Manager application persist its configs
    local HOME_CLEARNET_CONFIG="/home/clearnet/.config"
    local HOME_CLEARNET_CONFIG_VMANAGER="${HOME_CLEARNET_CONFIG}/libvirt"
    local HOME_CLEARNET_CONFIG_VMANAGER_STORAGE="${HOME_CLEARNET_CONFIG}/libvirt/storage"
    local HOME_CLEARNET_CONFIG_VMANAGER_DEFAULT_POOL_FILE="${HOME_CLEARNET_CONFIG_VMANAGER_STORAGE}/${VMANAGER_CONFIG_FILENAME}"
    local HOME_CLEARNET_DEFAULT_STORAGE_POOL_LOCATION="/home/clearnet/HiddenVM/Virtual Machine Manager VMs"
    
    
    sudo -u clearnet mkdir -p "${HOME_CLEARNET_DEFAULT_STORAGE_POOL_LOCATION}"
    sudo rm -rf "${HOME_CLEARNET_CONFIG_VMANAGER}"
    sudo -u clearnet mkdir -p "${HOME_CLEARNET_CONFIG}"
    

    # If we have a cached vmanager config, copy it to the right location for updating
    if [ $(ls -A "$VMANAGER_CONFIG_CACHE_DIR" | wc -l) -ne 0 ]; then
    {
    	log "The config cache is not empty"
        sudo -u clearnet mkdir -p "${HOME_CLEARNET_CONFIG_VMANAGER_STORAGE}"
        sudo cp -r "${VMANAGER_DEFAULT_CONFIG_CACHE_FILE}" "${HOME_CLEARNET_CONFIG_VMANAGER_STORAGE}"
        sudo chown -R clearnet:clearnet "${HOME_CLEARNET_CONFIG_VMANAGER}"
    }
    else
    {
    	log "The config cache is empty"
    }    
    fi
    
    if [ -f "${VMANAGER_DEFAULT_CONFIG_CACHE_FILE}" ]; then
    {
        log "Found existing Virtual Machine Manager config: ${VMANAGER_DEFAULT_CONFIG_CACHE_FILE}"
        VMANAGER_DEFAULT_CONFIG_FILE_EXISTS=true
         
    }
    else
    {
        log "No previous Virtual Machine Manager config found"
    }
    fi

    log "Reached storage pool"

    # Check if the storage pool exists
    log "Checking if storage pool exists"
    
    if [ "$VMANAGER_DEFAULT_CONFIG_FILE_EXISTS" == false ]; then
    {
    	if ( get_active_pool_count === 0 ); then
    	{
    		# Create a storage pool if it doesn't exist as by default the installation doesn't create one
    		log "Storage pool is about to be created."
    		sudo -u clearnet virsh pool-define-as --name default --type dir --target \
        	"${HOME_CLEARNET_DEFAULT_STORAGE_POOL_LOCATION}"

    		log "Storage pool has been created."

   		# Now we start the default storage pool
    		sudo -u clearnet virsh pool-start default

		 #Setting the default storage to automatically start on app startup
		sudo -u clearnet virsh pool-autostart default
		   

    	}
    	else
    	{
    		log "Storage pool exists." 
    	}
    	fi
    }
    fi    
    
    #Added for test purposes
    sudo rm -rf "${HOME_CLEARNET_DEFAULT_STORAGE_POOL_LOCATION}"

    # Restart the libvirtd service
    sudo systemctl restart libvirtd
    
    #sudo killall libvirtd
    
    #sudo -u clearnet libvirtd
    
    pushd / >/dev/null
    
    log "pushd to launch directory"

    # Copy the updated default config file back to the cache
    sudo cp -r "${HOME_CLEARNET_CONFIG_VMANAGER_DEFAULT_POOL_FILE}" "${VMANAGER_CONFIG_CACHE_DIR}/"
    sudo chown -R amnesia:amnesia "${VMANAGER_CONFIG_CACHE_DIR}/"
    #sudo chmod -R 777 /etc/libvirt 
    sudo rm -rf "${HOME_CLEARNET_CONFIG_VMANAGER}"

    # Create a symlink to the cached vmanager config directory within the "HiddenVM"
    # mount. Because the mount isn't live yet, this symlink will remain broken
    # until the mount is established by the launcher.
    sudo -u clearnet ln -s "${CLEARNET_HVM_MOUNT}/cache/config-vmanager/libvirt" "${HOME_CLEARNET_CONFIG_VMANAGER}"

    popd > /dev/null
    
    # for testing purposes
    #sudo apt-get update
}
