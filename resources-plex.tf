# __generated__ by Terraform
# Please review these resources and move them into your main configuration files.

resource "docker_image" "plex" {
  name = var.plex_image
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
    "PGID=1000",
    "TZ=America/Los_Angeles",
    "PLEX_CLAIM=${var.plex_claim}",
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
  network_mode       = "host"
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

  mounts {
    type   = "bind"
    target = "/config"
    source = "/docker/plex/dj-plex"
  }

  mounts {
    type   = "bind"
    target = "/mnt/tv"
    source = "/mnt/vol1/media/shows"
  }

  mounts {
    type   = "bind"
    target = "/mnt/movies"
    source = "/mnt/vol1/media/movies"
  }

  mounts {
    type   = "bind"
    target = "/mnt/music"
    source = "/mnt/vol1/media/music"
  }

  healthcheck {
    interval       = "5s"
    retries        = 20
    start_interval = "0s"
    start_period   = "0s"
    test           = ["CMD-SHELL", "/healthcheck.sh || exit 1"]
    timeout        = "2s"
  }
}
