output "local-hostname" {
  description = "Displays local hostname that ran terraform"
  value       = "${data.external.local_data.result.hostname}"
}

output "portainer-webgui" {
  description = "WebGUI port for accessing Portainer"
  value       = "https://${data.external.local_data.result.ip}:9443"
}

output "qbittorrent-webgui" {
  description = "WebGUI port for accessing qBittorrent"
  value       = "http://${data.external.local_data.result.ip}:8080"
}

output "radarr-webgui" {
  description = "WebGUI port for accessing Radarr"
  value       = "http://${data.external.local_data.result.ip}:7878"
}

output "sonarr-webgui" {
  description = "WebGUI port for accessing Sonarr"
  value       = "http://${data.external.local_data.result.ip}:8989"
}

output "prowlarr-webgui" {
  description = "WebGUI port for accessing Prowlarr"
  value       = "http://${data.external.local_data.result.ip}:9696"
}

output "kopia-webgui" {
  description = "WebGUI port for accessing Kopia"
  value       = "http://${data.external.local_data.result.ip}:51515"
}