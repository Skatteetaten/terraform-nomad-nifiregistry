module "nifi_registry" {
  source = "../.."

  # nomad
  nomad_datacenters = ["dc1"]
  nomad_namespace   = "default"
  nomad_host_volume = "persistence"

  # nifi
  service_name    = "nifi-registry"
  host            = "127.0.0.1"
  port            = 18080
  container_image = "michalklempa/nifi-registry:0.8.0"
  use_host_volume = false
  use_canary      = false
  resource = {
    cpu    = 500
    memory = 1024
  }
  resource_proxy = {
    cpu    = 200
    memory = 128
  }

  # Git version control configuration
  git_remote_url             = ""
  git_checkout_branch        = ""
  git_flow_storage_directory = ""
  git_remote_to_push         = ""
  git_access_user            = ""
  git_access_password        = ""
  git_user_name              = ""
  git_user_email             = ""
}