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
  restart    = "unless-stopped"
  depends_on = [docker_container.qbittorrent-container]
  labels {
    label = "homepage.group"
    value = "Torrent Suite"
  }
  labels {
    label = "homepage.name"
    value = "Prowlarr"
  }
  labels {
    label = "homepage.icon"
    value = "prowlarr.png"
  }
  labels {
    label = "homepage.href"
    value = "http://${data.external.local_data.result.ip}:9696"
  }
  labels {
    label = "homepage.description"
    value = "Torrent index manager"
  }

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