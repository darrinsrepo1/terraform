###########################################
########## Qbittorrent Resources ##########
###########################################
# Creating docker image for qbittorrent at specific version
resource "docker_image" "qbittorrent" {
  name = var.qbittorrent_image
}

resource "docker_volume" "qbittorrent_appdata" {
  name = "qbittorrent-appdata"

  lifecycle {
    ignore_changes = all
  }
}

# Create folder for torrent downloads, required before qbittorrent resource since it mounts it
resource "null_resource" "create-torrents-folder" {
  provisioner "local-exec" {
    command = "mkdir -p /mnt/vol1/torrents"
  }
}

# Creating a Docker Container for qbittorrent
resource "docker_container" "qbittorrent-container" {
  image              = docker_image.qbittorrent.image_id
  name               = "tf-qbittorrent"
  env                = ["PUID=1000", "PGID=1000", "TZ=America/Los_Angeles"]
  must_run           = true
  restart            = "unless-stopped"
  cpu_period         = null
  cpu_quota          = null
  cpu_set            = null
  cpu_shares         = 0
  cpus               = 3
  memory             = 4096
  memory_reservation = 512
  memory_swap        = 0
  # Connect this container to Gluetun network. Required to use VPN for downloading
  network_mode = "container:${docker_container.gluetun-container.id}"
  depends_on = [
    docker_container.gluetun-container,
    null_resource.create-torrents-folder
  ]
  labels {
    label = "homepage.group"
    value = "Torrent Suite"
  }
  labels {
    label = "homepage.name"
    value = "qBittorrent"
  }
  labels {
    label = "homepage.icon"
    value = "qbittorrent.png"
  }
  labels {
    label = "homepage.href"
    value = "http://${data.external.local_data.result.ip}:8080"
  }
  labels {
    label = "homepage.description"
    value = "File downloader using Gluetun VPN"
  }

  volumes {
    host_path      = "/mnt/vol1/torrents"
    container_path = "/downloads"
    read_only      = false
  }
  volumes {
    volume_name    = docker_volume.qbittorrent_appdata.name
    container_path = "/config"
  }

  # Commented out since ports are handled through gluetun container. Uncomment if removing gluetun
  #  ports {
  #    protocol = "tcp"
  #    internal = 8080
  #    external = 8080
  #  }
  #  ports {
  #    protocol = "tcp"
  #    internal = 6881
  #    external = 6881
  #  }
  #  ports {
  #    protocol = "udp"
  #    internal = 6881
  #    external = 6881
  #  }
}

## Post-provision configurations via ansible
#resource "null_resource" "qbittorrent-inject-config-playbook" {
#  triggers = {
#    instance_id = docker_container.qbittorrent-container.id
#  }
#  provisioner "local-exec" {
#    command = "ansible-playbook -i /ansible/inventory/inventory.ini /ansible/playbooks/qbittorrent-inject-config.yml"
#  }
#  depends_on = [docker_container.qbittorrent-container]
#}
###########################################
