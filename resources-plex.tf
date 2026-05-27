# __generated__ by Terraform
# Please review these resources and move them into your main configuration files.

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
    "PLEX_CLAIM=claim-a-iWvQJzkRxi5bYkcthQ",
    "PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin",
    "TERM=xterm",
    "LANG=C.UTF-8",
    "LC_ALL=C.UTF-8",
    "CHANGE_CONFIG_DIR_OWNERSHIP=true",
    "HOME=/config"
  ]
  image              = "plexinc/pms-docker:latest"
  memory             = 0
  memory_reservation = 0
  memory_swap        = 0
  must_run           = true
  name               = "tf-plex"
  network_mode       = "host"
  restart            = "unless-stopped"
  shm_size           = 64

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
