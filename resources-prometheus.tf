###########################################
########## Prometheus Resources ##########
###########################################
# Creating docker image for prometheus at specific version
resource "docker_image" "prometheus" {
  name = var.prometheus_image
}

# Created persistent prometheus volumes
resource "docker_volume" "prometheus_data" {
  name = "prometheus-data"

  lifecycle {
    ignore_changes = all
  }
}

# Creating a Docker Container for prometheus
resource "docker_container" "prometheus-container" {
  image    = docker_image.prometheus.image_id
  name     = "tf-prometheus"
  env      = ["PUID=1000", "PGID=1000", "TZ=America/Los_Angeles"]
  must_run = true
  restart  = "unless-stopped"
  #depends_on = [  ]
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