# Creating docker image for homepage at specific version
resource "docker_image" "homepage" {
  name = var.homepage_image
}

# Created persistent homepage volumes
resource "docker_volume" "homepage_config" {
  name = "homepage-config"

  lifecycle {
    ignore_changes = all
  }
}

# Create docker.yaml prior to creating homepage container
resource "local_file" "homepage_docker_yaml" {
  content         = file("/terraform/managed_files/homepage/docker.yaml")
  filename        = "/var/lib/docker/volumes/homepage-config/_data/docker.yaml"
  file_permission = "0644"
  depends_on = [ docker_volume.homepage_config ]
}

# Sets ownership of the local file
resource "null_resource" "homepage_docker_yaml_ownership" {
  # The provisioner triggers only after the file resource is created
  triggers = {
    file_id = local_file.homepage_docker_yaml.id
  }

  provisioner "local-exec" {
    command = "sudo chown darrin:darrin ${local_file.homepage_docker_yaml.filename}"
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
  cpu_period         = null
  cpu_quota          = null
  cpu_set            = null
  cpu_shares         = 0
  cpus               = "2.0"
  memory             = 1024
  memory_reservation = 512
  memory_swap        = 1024

  depends_on = [ null_resource.homepage_docker_yaml_ownership ]

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