data "external" "local_data" {
  program = ["bash", "/terraform/scripts/export-local-data.sh"]
}