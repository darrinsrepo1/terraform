# Creating docker image for prometheus at specific version
resource "docker_image" "prometheus" {
  name = var.prometheus_image
}

# Create a Docker network for internal communication
resource "docker_network" "monitoring" {
  name = "monitoring"
}

# Created persistent prometheus volumes
resource "docker_volume" "prometheus_data" {
  name = "prometheus-data"

}

# Create Prometheus.yml prior to creating Prometheus container
resource "local_file" "prometheus_yml" {
  content         = file("/terraform/managed_files/prometheus/prometheus.yml")
  filename        = "/etc/prometheus/prometheus.yml"
  file_permission = "0644"
}

# Sets ownership of the local file
resource "null_resource" "prometheus_yml_ownership" {
  # The provisioner triggers only after the file resource is created
  triggers = {
    file_id = local_file.prometheus_yml.id
  }

  provisioner "local-exec" {
    command = "sudo chown 0:0 ${local_file.prometheus_yml.filename}"
  }
}

# Creating a Docker Container for prometheus
resource "docker_container" "prometheus-container" {
  image              = docker_image.prometheus.image_id
  name               = "tf-prometheus"
  env                = ["PUID=1000", "PGID=1000", "TZ=America/Los_Angeles"]
  must_run           = true
  restart            = "unless-stopped"
  depends_on         = [local_file.prometheus_yml]
  cpu_period         = null
  cpu_quota          = null
  cpu_set            = null
  cpu_shares         = 0
  cpus               = "2.0"
  memory             = 1024
  memory_reservation = 512
  memory_swap        = 1024

  networks_advanced {
    name = docker_network.monitoring.name
  }

  labels {
    label = "homepage.group"
    value = "Monitoring / Logging"
  }
  labels {
    label = "homepage.name"
    value = "prometheus"
  }
  labels {
    label = "homepage.icon"
    value = "prometheus.png"
  }
  labels {
    label = "homepage.href"
    value = "http://${data.external.local_data.result.ip}:9090"
  }
  labels {
    label = "homepage.description"
    value = "Metrics collector for network monitoring."
  }

  # Persistent settings for prometheus
  volumes {
    volume_name    = docker_volume.prometheus_data.name
    container_path = "/prometheus"
  }
  # Local config file
  volumes {
    host_path      = "/etc/prometheus/prometheus.yml"
    container_path = "/etc/prometheus/prometheus.yml"
  }

  ports {
    internal = 9090 # WebGUI Port
    external = 9090
  }
}