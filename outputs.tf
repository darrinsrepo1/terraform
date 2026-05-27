output "local-hostname" {
  description = "Displays local hostname that ran terraform"
  value       = data.external.local_data.result.hostname
}

output "webgui-urls" {
  description = "WebGUI ports for terraform container resources"
  value       = <<-EOT
    cAdvisor:      http://${data.external.local_data.result.ip}:8081
    Grafana:       http://${data.external.local_data.result.ip}:3001
    Jellyfin:      http://${data.external.local_data.result.ip}:8096
    Homepage:      http://${data.external.local_data.result.ip}:3000
    Plex:          http://${data.external.local_data.result.ip}:32400/web
    Portainer:     https://${data.external.local_data.result.ip}:9443
    Kopia:         http://${data.external.local_data.result.ip}:51515
    qBittorrent:   http://${data.external.local_data.result.ip}:8080
    Prowlarr:      http://${data.external.local_data.result.ip}:9696
    Radarr:        http://${data.external.local_data.result.ip}:7878
    Sonarr:        http://${data.external.local_data.result.ip}:8989
    Prometheus:    http://${data.external.local_data.result.ip}:9090
    Grafana:       http://${data.external.local_data.result.ip}:3001
    Node Exporter: http://${data.external.local_data.result.ip}:8100
  EOT
}