variable "cadvisor_image" {
  type        = string
  description = "Docker image for cadvisor container"
}

variable "gluetun_image" {
  type        = string
  description = "Docker image for qbittorrent container"
}

variable "grafana_image" {
  type        = string
  description = "Docker image for Grafana container"
}

variable "homepage_allowed_hosts" {
  type        = string
  description = "Hosts allowed to access Homepage url. E.g <host-ip> OR <host-ip>:<gui-port> OR * (for allowing all)"
  default     = "*"
}

variable "homepage_image" {
  type        = string
  description = "Docker image for Homepage landing page container"
}

variable "kopia_image" {
  type        = string
  description = "Docker image for kopia snapshotting container"
}

variable "kopia_password" {
  type        = string
  description = "Password for kopia"
  sensitive   = true
}

variable "kopia_user" {
  type        = string
  description = "User for kopia"
}

variable "node_exporter_image" {
  type        = string
  description = "Docker image for Noe Export Metrics container"
}

variable "openvpn_countries" {
  type        = string
  description = "OpenVPN Proton VPN Countries"
}

variable "openvpn_password" {
  type        = string
  description = "OpenVPN Proton VPN Password for gluetun"
  sensitive   = true
}

variable "openvpn_user" {
  type        = string
  description = "OpenVPN Proton VPN User name for gluetun"
}

variable "plex_claim" {
  type        = string
  description = "Plex claim token"
  sensitive   = true
}

variable "plex_image" {
  type        = string
  description = "Docker image for plex container"
}

variable "portainer_image" {
  type        = string
  description = "Docker image for portainer management container"
}

variable "prometheus_image" {
  type        = string
  description = "Docker image for prometheus monitoring container"
}

variable "prowlarr_image" {
  type        = string
  description = "Docker image for prowlarr indexer container"
}

variable "qbittorrent_image" {
  type        = string
  description = "Docker image for qbittorrent container"
}

variable "radarr_image" {
  type        = string
  description = "Docker image for radarr container"
}

variable "sonarr_image" {
  type        = string
  description = "Docker image for sonarr container"
}
