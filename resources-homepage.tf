###########################################
########### Homepage Resources ############
###########################################
# Creating docker image for homepage at specific version
resource "docker_image" "homepage" {
  name = var.homepage_image
}

# Created persistent homepage volumes
resource "docker_volume" "homepage_config" {
  name = "homepage-config"

  lifecycle {
    ignore_changes = [ all ]
  }
}

# Creating a Docker Container for homepage
resource "docker_container" "homepage-container" {
  image    = docker_image.homepage.image_id
  name     = "tf-homepage"
  must_run = true
  restart  = "unless-stopped"
  env = [
    "PUID=0",
    "PGID=0",
    "TZ=America/Los_Angeles",
    "HOMEPAGE_ALLOWED_HOSTS=${var.homepage_allowed_hosts}"
  ]
  mounts {
    type      = "bind"
    target    = "/var/run/docker.sock"
    source    = "/var/run/docker.sock"
    read_only = true
  }

  volumes {
    volume_name    = docker_volume.homepage_config.name
    container_path = "/app/config"
  }

  ports {
    internal = 3000 # WebGUI Port
    external = 3000
  }
}