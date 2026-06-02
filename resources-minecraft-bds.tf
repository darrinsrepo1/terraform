# __generated__ by Terraform then modified to needs
# Define image for minecraft server so it can be controllerd with others via tfvars
resource "docker_image" "minecraft" {
  name = var.minecraft-bds_image
}

# Define Minecraft server container resource to provision
resource "docker_container" "minecraft-bedrock" {
  cpu_shares = 0
  cpus       = "2.0"
  entrypoint = ["/usr/local/bin/entrypoint-demoter", "--match", "/data", "--debug", "--stdin-on-term", "stop", "/opt/bedrock-entry.sh"]
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
  hostname           = "713a5e6bf826"
  image              = docker_image.minecraft.image_id
  memory             = 3072
  memory_reservation = 2048
  memory_swap        = 3072
  must_run           = null
  name               = "tf-minecraft-bds"
  network_mode       = "minecraft-bedrock-server_default"
  privileged         = false
  restart            = "unless-stopped"
  shm_size           = 64
  stdin_open         = true
  tty                = true
  working_dir        = "/data"
  healthcheck {
    interval       = "0s"
    retries        = 0
    start_interval = "0s"
    start_period   = "1m0s"
    test           = ["CMD-SHELL", "/usr/local/bin/mc-monitor status-bedrock --host 127.0.0.1 --port $SERVER_PORT"]
    timeout        = "0s"
  }
  # Portss for connecting to the server for gameplay
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
