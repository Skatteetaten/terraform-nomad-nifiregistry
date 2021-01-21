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

  # Git version control configuration
  git_remote_url             = yamldecode(file("../../dev/ansible/02_set_variables.yml"))[0]["set_fact"]["git_remote_url"]
  git_checkout_branch        = yamldecode(file("../../dev/ansible/02_set_variables.yml"))[0]["set_fact"]["git_checkout_branch"]
  git_flow_storage_directory = "/opt/nifi-registry/flow-storage"
  git_remote_to_push         = "origin"
  git_access_user            = "user"
  git_access_password        = "thisisnotmypassword"
  git_user_name              = "nifi-registry"
  git_user_email             = "nifi-registry@localhost"
}