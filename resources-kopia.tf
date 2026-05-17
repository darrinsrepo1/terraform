###########################################
########## Kopia Resources ##########
###########################################
# Creating docker image for kopia at specific version
resource "docker_image" "kopia" {
  name = var.kopia_image
}

# Created persistent kopia volumes
resource "docker_volume" "kopia_config" {
  name = "kopia-config"

  lifecycle {
    ignore_changes = [ all ]
  }
}
resource "docker_volume" "kopia_cache" {
  name = "kopia-cache"
}
resource "docker_volume" "kopia_logs" {
  name = "kopia-logs"
}
# Volume for saved backups
resource "docker_volume" "kopia_repo" {
  name = "kopia-repo"

  lifecycle {
    ignore_changes = [ all ]
  }
}
# Volume for browsing temporarily mounted snapshots
resource "docker_volume" "kopia_tmp" {
  name = "kopia-tmp"
}


# Creating a Docker Container for kopia
resource "docker_container" "kopia-container" {
  image    = docker_image.kopia.image_id
  hostname = "kopia-server"
  name     = "tf-kopia"
  must_run = true
  restart  = "unless-stopped"
  env = [
    "PUID=1000",
    "PGID=1000",
    "TZ=America/Los_Angeles",
    "USER=${var.kopia_user}",
    "KOPIA_PASSWORD=${var.kopia_password}"
  ]
  command = [
    "server",
    "start",
    "--disable-csrf-token-checks",
    "--insecure",
    "--address=0.0.0.0:51515",
    "--server-username=${var.kopia_user}",
    "--server-password=${var.kopia_password}"
  ]
  labels {
    label = "homepage.group"
    value = "Infra Management"
  }
  labels {
    label = "homepage.name"
    value = "Kopia"
  }
  labels {
    label = "homepage.icon"
    value = "kopia.png"
  }
  labels {
    label = "homepage.href"
    value = "http://${data.external.local_data.result.ip}:51515"
  }
  labels {
    label = "homepage.description"
    value = "Snapshot and backup manager for containers and volumes"
  }

  mounts {
    type      = "bind"
    source    = "/var/lib/docker/volumes"
    target    = "/data"
    read_only = true
  }

  volumes {
    volume_name    = docker_volume.kopia_config.name
    container_path = "/app/config"
  }
  volumes {
    volume_name    = docker_volume.kopia_cache.name
    container_path = "/app/cache"
  }
  volumes {
    volume_name    = docker_volume.kopia_logs.name
    container_path = "/app/logs"
  }
  # Mount path for saved backups
  volumes {
    volume_name    = docker_volume.kopia_repo.name
    container_path = "/repository"
  }
  # Mount path for browsing mounted snapshots
  volumes {
    volume_name    = docker_volume.kopia_tmp.name
    container_path = "/tmp"
  }

  ports {
    internal = 51515 # WebGUI Port
    external = 51515
  }
}