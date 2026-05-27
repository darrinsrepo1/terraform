###########################################
########## Portainer Resources ##########
###########################################
# Creating docker image for portainer at specific version
resource "docker_image" "portainer" {
  name = var.portainer_image
}

# Created persistent portainer volumes
resource "docker_volume" "portainer-data" {
  name = "portainer_data"

  lifecycle {
    ignore_changes = all
  }
}

# Creating a Docker Container for portainer
resource "docker_container" "portainer-container" {
  image = docker_image.portainer.image_id
  name  = "tf-portainer"
  env = [
    "PUID=0",
    "GUID=125",
    "TZ=America/Los_Angeles"
  ]
  must_run           = true
  restart            = "unless-stopped"
  cpu_period         = null
  cpu_quota          = null
  cpu_set            = null
  cpu_shares         = 0
  cpus               = "2.0"
  memory             = 2072
  memory_reservation = 512
  memory_swap        = 2072
  labels {
    label = "homepage.group"
    value = "Infra Management"
  }
  labels {
    label = "homepage.name"
    value = "Portainer"
  }
  labels {
    label = "homepage.icon"
    value = "portainer.png"
  }
  labels {
    label = "homepage.href"
    value = "https://${data.external.local_data.result.ip}:9443"
  }
  labels {
    label = "homepage.description"
    value = "Manages and provides details for containers"
  }

  # For some reason mounts works but volumes does not for declaring this
  # Requires research to discover why, likely related to mount options like r/ro
  mounts {
    type   = "bind"
    target = "/var/run/docker.sock"
    source = "/var/run/docker.sock"
  }
  mounts {
    type      = "bind"
    target    = "/etc/localtime"
    source    = "/etc/localtime"
    read_only = true
  }
  volumes {
    volume_name    = docker_volume.portainer-data.name
    container_path = "/data"
  }

  ports {
    internal = 9443 # Web Gui port
    external = 9443
  }
  ports {
    internal = 8000
    external = 8000
  }
}