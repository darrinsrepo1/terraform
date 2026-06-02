# Define docker image
resource "docker_image" "grafana" {
  name = var.grafana_image
}

# Deploy Grafana
resource "docker_container" "grafana" {
  image    = docker_image.grafana.image_id
  name     = "tf-grafana"
  env      = ["PUID=1000", "PGID=1000", "TZ=America/Los_Angeles"]
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
    value = "Monitoring / Logging"
  }
  labels {
    label = "homepage.name"
    value = "Grafana"
  }
  labels {
    label = "homepage.icon"
    value = "grafana.png"
  }
  labels {
    label = "homepage.href"
    value = "http://${data.external.local_data.result.ip}:3001"
  }
  labels {
    label = "homepage.description"
    value = "Graphing and analyzing metrics visually, primarily used with Prometheus"
  }

  #WebGUI port changed to 3001 due to port conflict with Homepage container
  ports {
    internal = 3000
    external = 3001
  }
  networks_advanced {
    name = docker_network.monitoring.name
  }
}
