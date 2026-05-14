# Terraform Repository for Darrins Homelab

- Total HCL Code Lines = 423 (calculated w/ "cloc *.tf")
- Total Containers Managed = 7

- Defines homelab as code and uses Ansible for managing items that are not ideal to be managed in Terraform

## TODO
- Monitoring container
- Graphing container
- Logging container
- Porting Plex container into Terraform
- Configuring Jellyfin offline backup container
- Porting kids's Minecraft server into Terraform
- Migrating Terraform into dedicated server(move from laptop)
- Remove Ansible backups logic in favor of Kopia snapshots
- Rewrite Plex backup script on dedicated server into Kopia (once migrated)
- Revamp container image version management via Terraform
  
## Moving Resources
When moving resources into a module or changing minor items that would force a rebuild due to state change:

moved {    # Place in main.tf
  from = {provider.resource_name}  # Original Resource Address)
  to = {provider.resource_name}    # New Resource Address)
}

- Create a "moved" block for defining the move inside main.tf
- Create new resource and remove old resource
- Run "terraform plan" to validate the move
- Run "terraform apply" to apply the resource move in the state file
- Delete the moved block or archive it commented out in moved.tf

## Removing Resources
When removing resources from terraform state to manage outside terraform, use this to prevent it from being destroyed:

removed {    # Place in main.tf
  from = {provider.resource_name}
  lifecycle {
    destroy = false    # Always set to false to prevent destruction
  }
}

- Create the removed block in main.tf
- Remove the old resource from your .tf
- Run "terraform plan" to verify change
- Run "terraform apply" to remove the resource from the state file
- Delete the removed block or archive it commented out in removed.tf

## Import Resources
When trying to take control of existing resources that haven't been managed in terraform yet or have been managed by another terraform environment:

import {    # Place in main.tf
    to = {provider.resource_name}    # Resource that will manage going forward
    id = "Value to manage"    # The new secret, repo, or subscription
}

- Create the new resource in your terraform config
- Create the import block in main.tf
- Run "terraform plan" to verify the import is correct
- Run "terraform apply" to apply the change
- Delete the import block or archive it commented out in import.tf

## Gluetun (ProtonVPN via OpenVPN)
- Established VPN network for other containers
- Containers using this VPN network must have ports defined inside gluetun
- Currently used by:  
qBittorrent  

## Kopia
- Backup Manager for containers
- Snapshots managed:  
qbittorrent-appdata  

## qBittorrent
- qBittorrent container used gluetun container for network
- When porting to dedicated server, qbittorrent needs downloads folder adjusted  

(migrating to kopia, kopia already backs up qBittorrent appdata entirely)  
To load a custom qBittorrent.conf:
- Stop the container
- Copy new qBittorrent.conf to /config/qBittorrent/
docker cp /local/path/qBittorrent.conf <container_id>:/config/qBittorrent/
- Start the container  