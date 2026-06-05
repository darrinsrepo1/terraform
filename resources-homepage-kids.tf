## Homepage container specifically for the kids
# Created persistent homepage volumes
resource "docker_volume" "homepage_kids_config" {
  name = "homepage-kids-config"
}

# Create Homepage Kids SETTINGS prior to creating homepage container
resource "local_file" "homepage_kids_settings_yaml" {
  content         = file("/terraform/managed_files/homepage-kids/settings.yaml")
  filename        = "/var/lib/docker/volumes/homepage-config/_data/settings.yaml"
  file_permission = "0644"
  depends_on      = [docker_volume.homepage_kids_config]
}

# Sets ownership of the local file
resource "null_resource" "homepage_kids_settings_yaml_ownership" {
  # The provisioner triggers only after the file resource is created
  triggers = {
    file_id = local_file.homepage_kids_settings_yaml.id
  }

  provisioner "local-exec" {
    command = "sudo chown 1000:1000 ${local_file.homepage_kids_settings_yaml.filename}"
  }
}

# Create Homepage Kids BOOKMARKS prior to creating homepage container
resource "local_file" "homepage_kids_bookmarks_yaml" {
  content         = file("/terraform/managed_files/homepage-kids/bookmarks.yaml")
  filename        = "/var/lib/docker/volumes/homepage-config/_data/bookmarks.yaml"
  file_permission = "0644"
  depends_on      = [docker_volume.homepage_kids_config]
}

# Sets ownership of the local file
resource "null_resource" "homepage_kids_bookmarks_yaml_ownership" {
  # The provisioner triggers only after the file resource is created
  triggers = {
    file_id = local_file.homepage_kids_bookmarks_yaml.id
  }

  provisioner "local-exec" {
    command = "sudo chown 1000:1000 ${local_file.homepage_kids_bookmarks_yaml.filename}"
  }
}

# Create Homepage Kids SERVICES prior to creating homepage container
resource "local_file" "homepage_kids_services_yaml" {
  content         = file("/terraform/managed_files/homepage-kids/services.yaml")
  filename        = "/var/lib/docker/volumes/homepage-config/_data/services.yaml"
  file_permission = "0644"
  depends_on      = [docker_volume.homepage_kids_config]
}

# Sets ownership of the local file
resource "null_resource" "homepage_kids_services_yaml_ownership" {
  # The provisioner triggers only after the file resource is created
  triggers = {
    file_id = local_file.homepage_kids_services_yaml.id
  }

  provisioner "local-exec" {
    command = "sudo chown 1000:1000 ${local_file.homepage_kids_services_yaml.filename}"
  }
}

# Creating a Docker Container for homepage
resource "docker_container" "homepage_kids_container" {
  image    = docker_image.homepage.image_id
  name     = "tf-homepage-kids"
  must_run = true
  restart  = "unless-stopped"
  env = [
    "PUID=0",
    "PGID=0",
    "TZ=America/Los_Angeles",
    "HOMEPAGE_ALLOWED_HOSTS=${var.homepage_allowed_hosts}"
  ]
  cpus               = "1.0"
  memory             = 1024
  memory_reservation = 0
  memory_swap        = 1024
  depends_on         = []

  volumes {
    volume_name    = docker_volume.homepage_kids_config.name
    container_path = "/app/config"
  }

  # WebGUI Port
  ports {
    internal = 3000
    external = 3999
  }
}