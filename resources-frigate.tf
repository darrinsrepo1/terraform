resource "docker_image" "frigate" {
  name = var.frigate_image
}

resource "docker_volume" "frigate_config" {
  name = "frigate-config"
}

resource "docker_container" "frigate" {
  name       = "tf-frigate"
  image      = docker_image.frigate.image_id
  restart    = "unless-stopped"
  privileged = true # Needed for hardware acceleration and TPU passthrough
  cpu_shares = 0
  cpus       = "2.0"
  shm_size   = 256 # Update depending on your camera count and resolution
  # Labels for homepage autopopulation
  labels {
    label = "homepage.group"
    value = "Security"
  }
  labels {
    label = "homepage.name"
    value = "Frigate NVR"
  }
  labels {
    label = "homepage.icon"
    value = "frigate.png"
  }
  labels {
    label = "homepage.href"
    value = "http://${data.external.local_data.result.ip}:5000"
  }
  labels {
    label = "homepage.description"
    value = "Organizes and accesses Camera System feeds"
  }

  # WebGUI Access port
  ports {
    internal = 5000
    external = 5000
    protocol = "tcp"
  }

  volumes {
    volume_name    = docker_volume.frigate_config.name
    container_path = "/config"
  }

  volumes {
    host_path      = "/mnt/vol1/data/frigate/media"
    container_path = "/media/frigate"
  }

  volumes {
    host_path      = "/etc/localtime"
    container_path = "/etc/localtime"
    read_only      = true
  }

  devices {
    host_path      = "/dev/bus/usb"
    container_path = "/dev/bus/usb"
  }

  devices {
    host_path      = "/dev/dri"
    container_path = "/dev/dri"
    permissions    = "rwm" # Optional: defaults to read, write, mknod
  }

  env = [
    "FRIGATE_RTSP_PASSWORD=${var.frigate_rstp_password}"
  ]
}