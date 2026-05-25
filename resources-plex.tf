# __generated__ by Terraform
# Please review these resources and move them into your main configuration files.

# __generated__ by Terraform from "1f89a31db0e1584cd64742710e478e8d77c8c0a4de95e1355efeb52f78ac9930"
resource "docker_container" "plex" {
  attach                                      = null
  cgroup_parent                               = null
  cgroupns_mode                               = null
  command                                     = []
  container_read_refresh_timeout_milliseconds = null
  cpu_period                                  = null
  cpu_quota                                   = null
  cpu_set                                     = null
  cpu_shares                                  = 0
  cpus                                        = null
  destroy_grace_seconds                       = null
  dns                                         = []
  dns_opts                                    = []
  dns_search                                  = []
  domainname                                  = null
  entrypoint                                  = ["/init"]
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
  gpus               = null
  group_add          = []
  image              = "plexinc/pms-docker:latest"
  init               = false
  ipc_mode           = "private"
  log_driver         = "json-file"
  log_opts           = {}
  logs               = null
  max_retry_count    = 0
  memory             = 0
  memory_reservation = 0
  must_run           = null
  name               = "plex"
  network_mode       = "host"
  pid_mode           = null
  platform           = "linux"
  privileged         = false
  publish_all_ports  = false
  read_only          = false
  remove_volumes     = null
  restart            = "unless-stopped"
  rm                 = false
  runtime            = "runc"
  security_opts      = []
  shm_size           = 64
  start              = null
  stdin_open         = false
  stop_signal        = null
  stop_timeout       = 0
  storage_opts       = {}
  sysctls            = {}
  tmpfs              = {}
  tty                = false
  user               = null
  userns_mode        = null
  wait               = null
  wait_timeout       = null
  working_dir        = null

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
