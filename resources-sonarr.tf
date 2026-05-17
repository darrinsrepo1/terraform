###########################################
########## Sonarr Resources ##########
###########################################
# Creating docker image for sonarr at specific version
resource "docker_image" "sonarr" {
  name = var.sonarr_image
}

# Created persistent sonarr volumes
resource "docker_volume" "sonarr_config" {
  name = "sonarr-config"
  
  lifecycle {
    ignore_changes = [ all ]
  }
}
resource "docker_volume" "sonarr_shows" {
  name = "sonarr-shows"

}

# Creating a Docker Container for sonarr
resource "docker_container" "sonarr-container" {
  image      = docker_image.sonarr.image_id
  name       = "tf-sonarr"
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
    value = "Sonarr"
  }
  labels {
    label = "homepage.icon"
    value = "sonarr.png"
  }
  labels {
    label = "homepage.href"
    value = "http://${data.external.local_data.result.ip}:8989"
  }
  labels {
    label = "homepage.description"
    value = "TV Show media manager, downloader, and organizer"
  }

  volumes {
    volume_name    = docker_volume.sonarr_config.name
    container_path = "/config"
  }
  volumes {
    volume_name    = docker_volume.sonarr_shows.name
    container_path = "/tv"
  }
  volumes {
    volume_name    = docker_volume.qbittorrent_downloads.name
    container_path = "/downloads"
  }

  ports {
    internal = 8989 # WebGUI Port
    external = 8989
  }
}