# Define docker image
resource "docker_image" "cadvisor" {
  name = var.cadvisor_image
}

# Deploy cAdvisor
resource "docker_container" "cadvisor" {
  image    = docker_image.cadvisor.image_id
  name     = "tf-cadvisor"
  env      = ["PUID=1000", "PGID=1000", "TZ=America/Los_Angeles"]
  must_run = true
  restart  = "unless-stopped"
  #depends_on = [  ]
  cpu_period         = null
  cpu_quota          = null
  cpu_set            = null
  cpu_shares         = 0
  cpus               = "1.0"
  memory             = 1024
  memory_reservation = 512
  memory_swap        = 1024
  privileged         = true

  labels {
    label = "homepage.group"
    value = "Monitoring / Logging"
  }
  labels {
    label = "homepage.name"
    value = "cAdvisor"
  }
  labels {
    label = "homepage.icon"
    value = "cadvisor.png"
  }
  labels {
    label = "homepage.href"
    value = "http://${data.external.local_data.result.ip}:8081"
  }
  labels {
    label = "homepage.description"
    value = "Pulls container related metrics, primarily used with Prometheus"
  }

  mounts {
    type      = "bind"
    target    = "/rootfs"
    source    = "/"
    read_only = true
  }
  mounts {
    type      = "bind"
    target    = "/var/run"
    source    = "/var/run"
    read_only = true
  }
  mounts {
    type      = "bind"
    target    = "/sys"
    source    = "/sys"
    read_only = true
  }
  mounts {
    type      = "bind"
    target    = "/var/lib/docker"
    source    = "/var/lib/docker"
    read_only = true
  }
  mounts {
    type      = "bind"
    target    = "/dev/disk"
    source    = "/dev/disk"
    read_only = true
  }

  ports {
    internal = 8080
    external = 8081 #Changed to 8081 due to port conflict with Homepage container
  }

  devices {
    host_path   = "/dev/kmsg"
    permissions = "r" # Optional: defaults to read, write, mknod
  }
}
