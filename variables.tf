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

variable "mode" {
  type        = string
  description = "Switch for nomad jobs to use standalone or standalone with git deployment"
  default     = "standalone"
  validation {
    condition     = var.mode == "standalone" || var.mode == "git"
    error_message = "Valid modes: \"git\" or \"standalone\"."
  }
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

# Git version control configuration
variable "git_remote_url" {
  type        = string
  description = "URL of the remote git repository. Must be HTTPS."
  default     = "default"
}

variable "git_checkout_branch" {
  type        = string
  description = "Branch to checkout and track."
  default     = ""
}

variable "git_flow_storage_directory" {
  type        = string
  description = "Destination directory for clone."
  default     = "/opt/nifi-registry/flow-storage"
}

variable "git_remote_to_push" {
  type        = string
  description = "This variable is used in clone script to set origin name."
  default     = "origin"
}

variable "git_access_user" {
  type        = string
  description = "Username"
  default     = ""
}

variable "git_access_password" {
  type        = string
  description = "Password"
  default     = ""
}

variable "git_user_name" {
  type        = string
  description = "Developer"
  default     = "nifi-registry"
}

variable "git_user_email" {
  type        = string
  description = "Developer email"
  default     = "nifi-registry@localhost"
}






