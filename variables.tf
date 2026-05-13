variable "gluetun_image" {
  type        = string
  description = "Docker image for qbittorrent container"
}

variable "openvpn_user" {
  type        = string
  description = "OpenVPN Proton VPN User name for gluetun"
}

variable "openvpn_password" {
  type        = string
  description = "OpenVPN Proton VPN Password for gluetun"
}

variable "openvpn_countries" {
  type        = string
  description = "OpenVPN Proton VPN Countries"
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

variable "prowlarr_image" {
  type        = string
  description = "Docker image for prowlarr container"
}

variable "portainer_image" {
  type        = string
  description = "Docker image for portainer container"
}

variable "kopia_image" {
  type        = string
  description = "Docker image for kopia container"
}

variable "kopia_user" {
  type        = string
  description = "User for kopia"
}

variable "kopia_password" {
  type        = string
  description = "Password for kopia"
}

variable "homepage_image" {
  type        = string
  description = "Docker image for Homepage container"
}