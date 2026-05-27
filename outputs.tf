output "local-hostname" {
  description = "Displays local hostname that ran terraform"
  value       = data.external.local_data.result.hostname
}

output "webgui-urls" {
  description = "WebGUI ports for terraform container resources"
  value       = <<-EOT
    Homepage:      http://${data.external.local_data.result.ip}:3000
    Portainer:     https://${data.external.local_data.result.ip}:9443
    Kopia:         http://${data.external.local_data.result.ip}:51515
    qBittorrent:   http://${data.external.local_data.result.ip}:8080
    Prowlarr:      http://${data.external.local_data.result.ip}:9696
    Radarr:        http://${data.external.local_data.result.ip}:7878
    Sonarr:        http://${data.external.local_data.result.ip}:8989
    Prometheus:    http://${data.external.local_data.result.ip}:9090
    Node Exporter: http://${data.external.local_data.result.ip}:8100
  EOT
}