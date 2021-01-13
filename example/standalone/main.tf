module "nifi_registry" {
  source = "../.."

  # nomad
  nomad_datacenters = ["dc1"]
  nomad_namespace   = "default"

  # nifi registry
  service_name    = "nifi-registry"
  host            = "127.0.0.1"
  port            = 18080
  mode            = "standalone"
  container_image = "apache/nifi-registry:0.8.0"
  use_canary      = false
  resource = {
    cpu    = 500
    memory = 1024
  }
  resource_proxy = {
    cpu    = 200
    memory = 128
  }
}
