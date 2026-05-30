# Defining docker image for gluetun
resource "docker_image" "gluetun" {
  name = var.gluetun_image
}

# Creating network for gluetun container
resource "docker_network" "vpn_net" {
  name = "gluetun_network"
}

# Defining resource for gluetun container
resource "docker_container" "gluetun-container" {
  name    = "tf-gluetun"
  image   = docker_image.gluetun.image_id
  restart = "unless-stopped"
  # Adding network capability for VPN routing
  capabilities {
    add = ["CAP_NET_ADMIN"]
  }
  cpu_period         = null
  cpu_quota          = null
  cpu_set            = null
  cpu_shares         = 0
  cpus               = "2.0"
  memory             = 2072
  memory_reservation = 512
  memory_swap        = 2072
  labels {
    label = "homepage.group"
    value = "Network"
  }
  labels {
    label = "homepage.name"
    value = "Gluetun VPN"
  }
  labels {
    label = "homepage.icon"
    value = "gluetun.png"
  }
  labels {
    label = "homepage.description"
    value = "VPN Container using OpenVPN with ProtonVPN to route container traffic through VPN"
  }

  devices {
    host_path      = "/dev/net/tun"
    container_path = "/dev/net/tun"
  }

  env = [
    "VPN_SERVICE_PROVIDER=protonvpn",
    "VPN_TYPE=openvpn",
    "OPENVPN_USER=${var.openvpn_user}",
    "OPENVPN_PASSWORD=${var.openvpn_password}",
    "SERVER_COUNTRIES=${var.openvpn_countries}",
  ]

  networks_advanced {
    name = docker_network.vpn_net.name
  }

  # Expose ports through the VPN
  ports {
    internal = 8888
    external = 8888 # HTTP Proxy
  }
  ports {
    internal = 8080 # qbittorrent webgui
    external = 8080
  }
  ports {
    internal = 6881 # qbittorrent tcp traffic
    external = 6881
  }
  ports {
    protocol = "udp"
    internal = 6881 # qbittorrent udp traffic
    external = 6881
  }
}
###########################################