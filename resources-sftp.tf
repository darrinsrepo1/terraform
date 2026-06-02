resource "docker_image" "sftp" {
  name = var.sftp_image
}

resource "docker_container" "sftp" {
  image              = docker_image.sftp.image_id
  name               = "tf-sftp"
  env                = ["PUID=1000", "PGID=1000", "TZ=America/Los_Angeles"]
  must_run           = true
  restart            = "unless-stopped"
  command            = ["camera_user:CameraSecurePass123:1000:1000:upload"]
  cpu_shares         = 0
  cpus               = "1.0"
  memory             = 2072
  memory_reservation = 512
  memory_swap        = 2072
  #network_mode       = "bridge"
  #depends_on = [  ]
  # Labels for homepage autopopulation
  labels {
    label = "homepage.group"
    value = "Network"
  }
  labels {
    label = "homepage.name"
    value = "sftp"
  }
  labels {
    label = "homepage.icon"
    value = "sftp.png"
  }
  labels {
    label = "homepage.href"
    value = "${data.external.local_data.result.ip}:22"
  }
  labels {
    label = "homepage.description"
    value = "For backing up data for various services"
  }

  # Volume for camera feed backup
  volumes {
    #   volume_name    = docker_volume.sftp_cameras.name
    host_path      = "/mnt/vol1/sftp/cameras/"
    container_path = "/camera_footage"
  }

  # sftp port
  ports {
    internal = 21
    external = 21
    protocol = "tcp"
  }
}