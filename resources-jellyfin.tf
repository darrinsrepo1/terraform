# Pull the Jellyfin image
resource "docker_image" "jellyfin" {
  name         = var.jellyfin_image
  keep_locally = true
}

# Created persistent jellyfin volumes
resource "docker_volume" "jellyfin_config" {
  name = "jellyfin-config"
}

# Created persistent jellyfin volumes
resource "docker_volume" "jellyfin_cache" {
  name = "jellyfin-cache"
}

# Create the Jellyfin container
resource "docker_container" "jellyfin" {
  image      = docker_image.jellyfin.image_id
  name       = "tf-jellyfin"
  restart    = "unless-stopped"
  cpu_shares = 0
  env = [
    "PUID=1000",
    "PGID=1000",
    "TZ=America/Los_Angeles",
  ]
  memory             = 4096
  memory_reservation = 512
  memory_swap        = 4096
  must_run           = true
  shm_size           = 64
  # Labels for homepage autopopulation
  labels {
    label = "homepage.group"
    value = "Media"
  }
  labels {
    label = "homepage.name"
    value = "Jellyfin"
  }
  labels {
    label = "homepage.icon"
    value = "jellyfin.png"
  }
  labels {
    label = "homepage.href"
    value = "http://${data.external.local_data.result.ip}:8096"
  }
  labels {
    label = "homepage.description"
    value = "Home media streaming service (Plex Backup)"
  }

  # WebGUI access port
  ports {
    internal = 8096
    external = 8096
    protocol = "tcp"
  }
  ports {
    internal = 7359
    external = 7359
    protocol = "udp"
  }
  # 1900 conflicts with Plex DLNA
  ports {
    internal = 1900
    external = 1905
    protocol = "udp"
  }

  # Configuration and Media Volumes
  volumes {
    volume_name    = docker_volume.jellyfin_config.name
    container_path = "/config"
  }

  volumes {
    volume_name    = docker_volume.jellyfin_cache.name
    container_path = "/cache"
  }

  volumes {
    host_path      = "/mnt/vol1/media" # Update this to your local media path
    container_path = "/media"
    read_only      = true
  }

  #Required for hardware acceleration (optional)
  devices {
    host_path      = "/dev/dri"
    container_path = "/dev/dri"
    permissions    = "rwm" # Optional: defaults to read, write, mknod
  }
}