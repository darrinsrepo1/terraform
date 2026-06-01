# Terraform Repository for Darrins Homelab

- Total HCL Code Lines = 1235    # cloc /terraform/*.tf
- Total Comment Lines = 148
- Total Resources = 51          # terraform state list | wc -l : HCP Free Tier Requires < 500
- Total Containers Managed = 15

- Defines homelab as code and uses Ansible for managing items that are not ideal to be managed in Terraform

## TODO
- Setup FTP container 
- Setup Home assistant container 
- Setup Nextcloud container 
- Setup Alerting container
- Setup alerts and custon checks for plex video file access as user
- Setup Ansible Playbook to update homepage to stored files after it's provisioned(docker.yaml)
- Setup modules to break resources files into resource type folders
- Activate playbook to apply qbittorrent backup(kopia snapshot fails, needs work)
- Rewrite Plex backup script on dedicated server into Kopia (once migrated)
- Revamp container image version management via Terraform
  
# Git Workflow
Prod Server Branch = main  
Test Box Branch = develop  
  
##Workflow Example for New Features: 
- Pull recent develop to Test Box  (git checkout develop && git pull origin develop)
- Create and switch to feature branch on Test Box  (git checkout -b feature/feature-name)
- Test feature until happy and then commit  (git add . && git commit -m "detailed feature commit") 
- Push feature to Remote  (git push origin feature/feature-name)
- Create PR to merge feature into develop  (Review in github, create PR for feature/feature-name ~> develop)
- Review PR and then merge PR into develop  (From PR in github)
- Pull develop to Test Box and ensure changes present  (git checkout develop && git pull origin develop)
- Delete feature branch from local and remote  (git branch -d feature/feature-name && git push origin --delete feature/feature-name)
  
##To Deploy Current Developent Branch to Main:
- Ensure Test Box is using latest develop  (git checkout develop && git pull origin develop)
- Verify develop branch works on Test Box one last time  (perform terraform workflow)
- Create PR in github  (From github create PR for develop ~> main)
- Final review of PR changes
- Merge develop into main  (click merge inside PR)
- On Prod Server pull latest main  (git checkout main && git pull origin main)
- Deploy new changes on Prod Server via terraform workflow (terraform init; terraform plan; terraform apply)
  
##To Create Urgent Hotfix for Production Issues:
- Switch to main branch and pull latest  (git checkout main && git pull origin main)
- Create hotfix branch  (git checkout -b hotfix/issue-description)
- Develop the fix and test in terraform workflow
- Add and commit working changes  (git add . && git commit -m "Detailed hotfix info")
- Push hotfix to origin  (git push origin hotfix/issue-description)
- Review changes in git, create git PR   (from git create PR for hotfix/issue-description ~> main)
- Merge into main from PR
- **Research version tagging**
- Merge into develop from PR
- From Prod Server checkout main and pull changes  (git checkout main && git pull origin main)
- Run terraform workflow to deploy changes
- Delete hotfix branch locally and remote  (git branch -d hotfix/issue-description && git push --delete hotfix/issue-description)
  

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
- Test imported block on

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

Use this to generate config from import block:
terraform plan -generate-config-out=<desired-resource-name>.tf

- Create the new resource in your terraform config
- Create the import block in main.tf
- Run "terraform plan" to verify the import is correct
- Run "terraform apply" to apply the change
- Delete the import block or archive it commented out in import.tf


# Running Containers
## cAdvisor
- Provides container metrics for prometheus/grafana
## Dozzle
- Provides strong look into container logs
## Frigate
- NVR solution using rstp feeds for smart cameras
## Gluetun (ProtonVPN via OpenVPN)
- Established VPN network for other containers
- Containers using this VPN network must have ports defined inside gluetun
- Currently used by:  
qBittorrent  
## Grafana
- Provides graphical dashboards of collected metrics
## Homepage
- Main page for my home network
## Jellyfin
- Alternate Media streaming software to Plex
## Kopia
- Backup Manager for containers
- Snapshots managed:  
qbittorrent-appdata  
## Minecraft Bedrock Server
- Kids minecraft server
- Needs solution for keeping tied to Nintendo Switch version
## Node Exporter
- Provides metrics for Prometheus / Grafana
## Plex
- Main media streaming service with a similar purpose to Jellyfin
## Portainer
- Container administrator WebGUI to simplify container tasks outside te CLI
## Prometheus
- Metrics scraper and aggregator that's a crucial step in the monitoring chain
## Prowlarr
## qBittorrent
- qBittorrent container used gluetun container for network
- When porting to dedicated server, qbittorrent needs downloads folder adjusted  

(migrating to kopia, kopia already backs up qBittorrent appdata entirely)  
To load a custom qBittorrent.conf:
- Stop the container
- Copy new qBittorrent.conf to /config/qBittorrent/
docker cp /local/path/qBittorrent.conf <container_id>:/config/qBittorrent/
- Start the container  
## Radaar

## Sonarr
