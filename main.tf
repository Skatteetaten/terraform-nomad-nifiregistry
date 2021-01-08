locals {
  datacenters = join(",", var.nomad_datacenters)
  template_standalone = file("${path.module}/nomad/nifi_registry.hcl")
  template_git = file("${path.module}/nomad/nifi_registry.hcl")
}

data "template_file" "nomad_job_nifi_registry" {
  template = var.mode == "standalone" ? local.template_standalone : local.template_git
  vars = {
    datacenters     = local.datacenters
    namespace       = var.nomad_namespace
    host_volume     = var.nomad_host_volume
    image           = var.container_image
    service_name    = var.service_name
    host            = var.host
    port            = var.port
    cpu             = var.resource.cpu
    memory          = var.resource.memory
    cpu_proxy       = var.resource_proxy.cpu
    memory_proxy    = var.resource_proxy.memory
    use_host_volume = var.use_host_volume
    use_canary      = var.use_canary
  }
}

resource "nomad_job" "nomad_job_nifi_registry" {
  jobspec = data.template_file.nomad_job_nifi_registry.rendered
  detach  = false
}