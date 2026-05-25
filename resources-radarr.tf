###########################################
########## Radarr Resources ##########
###########################################
# Creating docker image for radarr at specific version
resource "docker_image" "radarr" {
  name = var.radarr_image
}

# Created persistent radarr volumes
resource "docker_volume" "radarr_config" {
  name = "radarr-config"

  lifecycle {
    ignore_changes = all
  }

}
resource "docker_volume" "radarr_movies" {
  name = "radarr-movies"

}

# Creating a Docker Container for radarr
resource "docker_container" "radarr-container" {
  image              = docker_image.radarr.image_id
  name               = "tf-radarr"
  env                = ["PUID=1000", "PGID=1000", "TZ=America/Los_Angeles"]
  must_run           = true
  restart            = "unless-stopped"
  cpu_period         = null
  cpu_quota          = null
  cpu_set            = null
  cpu_shares         = 0
  cpus               = "2.0"
  memory             = 2072
  memory_reservation = 512
  # Dependancy for qbittorrent removed since downloads volume is now a simple location instead of docker volume
  #depends_on = [docker_container.qbittorrent-container]
  labels {
    label = "homepage.group"
    value = "Torrent Suite"
  }
  labels {
    label = "homepage.name"
    value = "Radarr"
  }
  labels {
    label = "homepage.icon"
    value = "radarr.png"
  }
  labels {
    label = "homepage.href"
    value = "http://${data.external.local_data.result.ip}:7878"
  }
  labels {
    label = "homepage.description"
    value = "Movie media manager, downloader, and organizer"
  }

  volumes {
    volume_name    = docker_volume.radarr_config.name
    container_path = "/config"
  }
  volumes {
    volume_name    = docker_volume.radarr_movies.name
    container_path = "/movies"
  }
  # Location of qBittorrent download folder
  volumes {
    host_path      = "/mnt/vol1/torrents"
    container_path = "/downloads"
    read_only      = false
  }

  ports {
    internal = 7878 # WebGUI Port
    external = 7878
  }
}
###########################################