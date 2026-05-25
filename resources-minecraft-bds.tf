# __generated__ by Terraform
resource "docker_container" "minecraft-bedrock" {
  attach                                      = null
  cgroup_parent                               = null
  cgroupns_mode                               = null
  command                                     = []
  container_read_refresh_timeout_milliseconds = null
  cpu_period                                  = null
  cpu_quota                                   = null
  cpu_set                                     = null
  cpu_shares                                  = 0
  cpus                                        = 2
  destroy_grace_seconds                       = null
  dns                                         = []
  dns_opts                                    = []
  dns_search                                  = []
  domainname                                  = null
  entrypoint                                  = ["/usr/local/bin/entrypoint-demoter", "--match", "/data", "--debug", "--stdin-on-term", "stop", "/opt/bedrock-entry.sh"]
  env = [
    "VERSION=1.26.13.1",
    "OPS=2535421692867887",
    "EULA=TRUE",
    "PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin",
    "SERVER_PORT=19132",
    "SERVER_PORT_V6=19133",
    "ENABLE_BDS_V6BIND_FIX=false"
  ]
  gpus               = null
  group_add          = []
  hostname           = "713a5e6bf826"
  image              = "itzg/minecraft-bedrock-server"
  init               = false
  ipc_mode           = "private"
  log_driver         = "json-file"
  log_opts           = {}
  logs               = null
  max_retry_count    = 0
  memory             = 3072
  memory_reservation = 2048
  memory_swap        = 0
  must_run           = null
  name               = "tf-minecraft-bds"
  network_mode       = "minecraft-bedrock-server_default"
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
  stdin_open         = true
  stop_signal        = null
  stop_timeout       = 0
  storage_opts       = {}
  sysctls            = {}
  tmpfs              = {}
  tty                = true
  user               = null
  userns_mode        = null
  wait               = null
  wait_timeout       = null
  working_dir        = "/data"
  healthcheck {
    interval       = "0s"
    retries        = 0
    start_interval = "0s"
    start_period   = "1m0s"
    test           = ["CMD-SHELL", "/usr/local/bin/mc-monitor status-bedrock --host 127.0.0.1 --port $SERVER_PORT"]
    timeout        = "0s"
  }
  ports {
    external = 19132
    internal = 19132
    ip       = "0.0.0.0"
    protocol = "udp"
  }
  ports {
    external = 19132
    internal = 19132
    ip       = "::"
    protocol = "udp"
  }
}
