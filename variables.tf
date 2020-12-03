# Nomad
variable "nomad_datacenters" {
  type        = list(string)
  description = "Nomad data centers"
  default     = ["dc1"]
}
variable "nomad_namespace" {
  type        = string
  description = "[Enterprise] Nomad namespace"
  default     = "default"
}
variable "nomad_host_volume" {
  type        = string
  description = "Nomad Host Volume"
  default     = "persistence"
}

# Nifi registry
variable "service_name" {
  type        = string
  description = "Nifi registry service name"
  default     = "nifi-registry"
}
variable "host" {
  type        = string
  description = "Nifi registry host"
  default     = "127.0.0.1"
}
variable "port" {
  type        = number
  description = "Nifi registry port"
  default     = 18080
}
variable "container_image" {
  type        = string
  description = "Nifi registry docker image"
  default     = "apache/nifi-registry:0.8.0"
}
variable "resource" {
  type = object({
    cpu    = number,
    memory = number
  })
  default = {
    cpu    = 500,
    memory = 1024
  }
  description = "Nifi registry resources. CPU and memory allocation."
  validation {
    condition     = var.resource.cpu >= 500 && var.resource.memory >= 1024
    error_message = "Nifi registry resource must be at least: cpu=500, memory=1024."
  }
}

variable "resource_proxy" {
  type = object({
    cpu    = number,
    memory = number
  })
  default = {
    cpu    = 200,
    memory = 128
  }
  description = "Nifi proxy resources"
  validation {
    condition     = var.resource_proxy.cpu >= 200 && var.resource_proxy.memory >= 128
    error_message = "Proxy resource must be at least: cpu=200, memory=128."
  }
}

variable "use_host_volume" {
  type        = bool
  description = "Switch for nomad jobs to use host volume feature"
  default     = false
}

variable "use_canary" {
  type        = bool
  description = "Uses canary deployment for Nifi"
  default     = false
}
