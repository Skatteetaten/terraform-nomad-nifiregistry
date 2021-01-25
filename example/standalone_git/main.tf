module "nifi_registry" {
  source = "../.."

  # nomad
  nomad_datacenters = ["dc1"]
  nomad_namespace   = "default"


  # nifi
  service_name    = "nifi-registry"
  host            = "127.0.0.1"
  port            = 18080
  container_image = "michalklempa/nifi-registry:0.8.0"
  mode            = "standalone_git"
  use_canary      = false
  resource = {
    cpu    = 500
    memory = 1024
  }
  resource_proxy = {
    cpu    = 200
    memory = 128
  }
  vault_secret = {
    vault_kv_policy_name    = "kv-secret",
    vault_kv_path           = "secret/data/github",
    vault_kv_field_user     = "git_access_user",
    vault_kv_field_password = "git_access_password"
  }

  # Git version control configuration
  git_flow_storage_directory = "/opt/nifi-registry/flow-storage"
  git_remote_to_push         = "origin"

}