# __generated__ by Terraform
# Please review these resources and move them into your main configuration files.

resource "docker_image" "plex" {
  name = var.plex_image
}

resource "docker_volume" "plex_config" {
  name = "plex-config"
}

# __generated__ by Terraform from "1f89a31db0e1584cd64742710e478e8d77c8c0a4de95e1355efeb52f78ac9930"
resource "docker_container" "plex" {
  cpu_period = null
  cpu_quota  = null
  cpu_set    = null
  cpu_shares = 0
  cpus       = null
  env = [
    "PUID=1000",
    "PGID=1001",
    "PLEX_UID=1000",
    "PLEX_GID=1001",
    "TZ=America/Los_Angeles",
    #    "PLEX_CLAIM=${var.plex_claim}",
    "PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin",
    "TERM=xterm",
    "LANG=C.UTF-8",
    "LC_ALL=C.UTF-8",
    "CHANGE_CONFIG_DIR_OWNERSHIP=true",
    "HOME=/config"
  ]
  image              = docker_image.plex.image_id
  memory             = 0
  memory_reservation = 0
  memory_swap        = 0
  must_run           = true
  name               = "tf-plex"
#  network_mode       = "host"
  restart            = "unless-stopped"
  shm_size           = 64

  labels {
    label = "homepage.group"
    value = "Media"
  }
  labels {
    label = "homepage.name"
    value = "Plex"
  }
  labels {
    label = "homepage.icon"
    value = "plex.png"
  }
  labels {
    label = "homepage.href"
    value = "http://${data.external.local_data.result.ip}:32400/web"
  }
  labels {
    label = "homepage.description"
    value = "Home media streaming service"
  }

  devices {
    host_path      = "/dev/dri"
    container_path = "/dev/dri"
    permissions    = "rwm" # Optional: defaults to read, write, mknod
  }

  mounts {
    type      = "bind"
    target    = "/etc/localtime"
    source    = "/etc/localtime"
    read_only = true
  }

  volumes {
    volume_name = docker_volume.plex_config.name
    #    host_path      = "/docker/plex/dj-plex" # Update this to your local media path
    container_path = "/config"
  }

  #  mounts {
  #    type      = "bind"
  #    target    = "/media/shows"
  #    source    = "/mnt/vol1/media/shows"
  #  }
  volumes {
    host_path      = "/mnt/vol1/media/shows" # Update this to your local media path
    container_path = "/media/shows"
  }

  volumes {
    host_path      = "/mnt/vol1/media/movies" # Update this to your local media path
    container_path = "/media/movies"
  }

  volumes {
    host_path      = "/mnt/vol1/media/music" # Update this to your local media path
    container_path = "/media/music"
  }

  healthcheck {
    interval       = "5s"
    retries        = 20
    start_interval = "0s"
    start_period   = "0s"
    test           = ["CMD-SHELL", "/healthcheck.sh || exit 1"]
    timeout        = "2s"
  }

  ports {
    internal = 32400
    external = 32400
    protocol = "tcp"
  }
  ports {
    internal = 8324
    external = 8324
    protocol = "tcp"
  }
  ports {
    internal = 32469
    external = 32469
    protocol = "tcp"
  }
  ports {
    internal = 1900
    external = 1900
    protocol = "udp"
  }
  ports {
    internal = 32410
    external = 32410
    protocol = "udp"
  }
  ports {
    internal = 32412
    external = 32412
    protocol = "udp"
  }
  ports {
    internal = 32413
    external = 32413
    protocol = "udp"
  }
  ports {
    internal = 32414
    external = 32414
    protocol = "udp"
  }
}
