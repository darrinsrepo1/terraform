###########################################
########## Prowlarr Resources ##########
###########################################
# Creating docker image for sonarr at specific version
resource "docker_image" "prowlarr" {
  name = var.prowlarr_image
}

# Created persistent prowlarr volumes
resource "docker_volume" "prowlarr_config" {
  name = "prowlarr-config"
}

# Creating a Docker Container for prowlarr
resource "docker_container" "prowlarr-container" {
  image      = docker_image.prowlarr.image_id
  name       = "tf-prowlarr"
  env        = ["PUID=1000", "PGID=1000", "TZ=America/Los_Angeles"]
  must_run   = true
  restart = "unless-stopped"
  depends_on = [docker_container.qbittorrent-container]

  volumes {
    volume_name    = docker_volume.prowlarr_config.name
    container_path = "/config"
  }

  ports {
    protocol = "tcp"
    internal = 9696 # WebGUI Port
    external = 9696
  }
}

###########################################