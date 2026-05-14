###########################################
######### Node Exporter Resources #########
###########################################
# Creating docker image for node-exporter at specific version
resource "docker_image" "node-exporter" {
  name = var.node_exporter_image
}

# Creating a Docker Container for node-exporter
resource "docker_container" "node-exporter-container" {
  image    = docker_image.node-exporter.image_id
  name     = "tf-node-exporter"
  env      = [
    "PUID=1000", 
    "PGID=1000", 
    "TZ=America/Los_Angeles"
  ]
  #network_mode = "host"
  must_run = true
  restart  = "unless-stopped"
  command = [
    "--path.procfs=/host/proc",
    "--path.sysfs=/host/sys",
    "--collector.filesystem.ignored-mount-points=^/(sys|proc|dev|host|etc)($$|/)"
  ]
  #depends_on = [  ]
  labels {
    label = "homepage.group"
    value = "Monitoring / Logging"
  }
  labels {
    label = "homepage.name"
    value = "Node Exporter"
  }
  labels {
    label = "homepage.icon"
    value = "node-exporter.png"
  }
  labels {
    label = "homepage.href"
    value = "http://${data.external.local_data.result.ip}:9100"
  }
  labels {
    label = "homepage.description"
    value = "Exports metrics for a node for scraping."
  }

  # Node Exporter host system data locations
  volumes {
    host_path      = "/proc"
    container_path = "/host/proc"
    read_only      = true
  }
  volumes {
    host_path      = "/sys"
    container_path = "/host/sys"
    read_only      = true
  }
  volumes {
    host_path      = "/"
    container_path = "/rootfs"
    read_only      = true
  }

  ports {
    internal = 9100 # Metrics exposed port
    external = 9100
  }
}