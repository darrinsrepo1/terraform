data "external" "local_ipv4" {
  program = ["bash", "/terraform/scripts/export-local-ip.sh"]
}