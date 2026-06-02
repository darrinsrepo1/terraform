# Creating docker image for dozzle at specific version
resource "docker_image" "dozzle" {
  name = var.dozzle_image
}

# Creating a Docker Container for dozzle
resource "docker_container" "dozzle-container" {
  image = docker_image.dozzle.image_id
  name  = "tf-dozzle"
  env = [
    "PUID=1000",
    "PGID=1000",
    "TZ=America/Los_Angeles"
  ]
  #network_mode = "host"
  must_run = true
  restart  = "unless-stopped"
  #depends_on = [  ]
  cpu_shares         = 0
  cpus               = "2.0"
  memory             = 1024
  memory_reservation = 512
  memory_swap        = 1024
  # Labels for homepage autopopulation
  labels {
    label = "homepage.group"
    value = "Infra Management"
  }
  labels {
    label = "homepage.name"
    value = "Dozzle"
  }
  labels {
    label = "homepage.icon"
    value = "dozzle.png"
  }
  labels {
    label = "homepage.href"
    value = "http://${data.external.local_data.result.ip}:8082"
  }
  labels {
    label = "homepage.description"
    value = "Manages Docker logging in realtime"
  }

  # Allows access to docker resources
  mounts {
    type      = "bind"
    target    = "/var/run/docker.sock"
    source    = "/var/run/docker.sock"
    read_only = true
  }

  # dozzle port for WebUI, external port is 8082 due to conficts with other containers
  ports {
    internal = 8080
    external = 8082
    protocol = "tcp"
  }
}