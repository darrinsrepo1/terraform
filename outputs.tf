output "local-hostname" {
  description = "Displays local hostname that ran terraform"
  value       = data.external.local_data.result.hostname
}

output "webgui-urls" {
  description = "WebGUI ports for terraform container resources"
  value       = <<-EOT
    cAdvisor:      http://${data.external.local_data.result.ip}:8081
    Dozzle:        http://${data.external.local_data.result.ip}:8082
    Frigate:       http://${data.external.local_data.result.ip}:5000
    Grafana:       http://${data.external.local_data.result.ip}:3001
    Homepage:      http://${data.external.local_data.result.ip}:3000
    Jellyfin:      http://${data.external.local_data.result.ip}:8096
    Kopia:         http://${data.external.local_data.result.ip}:51515
    Node Exporter: http://${data.external.local_data.result.ip}:8100
    Plex:          http://${data.external.local_data.result.ip}:32400/web
    Portainer:     https://${data.external.local_data.result.ip}:9443
    Prometheus:    http://${data.external.local_data.result.ip}:9090
    Prowlarr:      http://${data.external.local_data.result.ip}:9696
    qBittorrent:   http://${data.external.local_data.result.ip}:8080
    Radarr:        http://${data.external.local_data.result.ip}:7878
    Sonarr:        http://${data.external.local_data.result.ip}:8989
  EOT
}