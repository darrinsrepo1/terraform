# Terraform Repository for Darrins Homelab

- Total HCL Code Lines = 396 (run this in ./prod: cloc *.tf)
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