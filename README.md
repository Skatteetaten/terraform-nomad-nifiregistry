<!-- markdownlint-disable MD041 -->
<p align="center"><a href="https://github.com/fredrikhgrelland/vagrant-hashistack-template" alt="Built on"><img src="https://img.shields.io/badge/Built%20from%20template-Vagrant--hashistack--template-blue?style=for-the-badge&logo=github"/></a><p align="center"><a href="https://github.com/fredrikhgrelland/vagrant-hashistack" alt="Built on"><img src="https://img.shields.io/badge/Powered%20by%20-Vagrant--hashistack-orange?style=for-the-badge&logo=vagrant"/></a></p></p>

# Terraform-module-nifiregistry
This module is IaC - infrastructure as code which contains a nomad job of [Nifi registry](https://nifi.apache.org/registry.html).

## Content
0. [Prerequisites](#prerequisites)
1. [Compatibility](#compatibility)
2. [Requirements](#requirements)
    1. [Required software](#required-software)
3. [Usage](#usage)
    1. [Verifying setup](#verifying-setup)
    2. [Providers](#providers)
4. [Example usage](#example-usage)
5. [Inputs](#inputs)
6. [Outputs](#outputs)
7. [Contributors](#contributors)
8. [License](#license)

## Prerequisites
Please follow [this section in original template](https://github.com/fredrikhgrelland/vagrant-hashistack-template#install-prerequisites).

## Compatibility
|Software|OSS Version|Enterprise Version|
|:---|:---|:---|
|Terraform|0.13.1 or newer||
|Consul|1.8.3 or newer|1.8.3 or newer|
|Vault|1.5.2.1 or newer|1.5.2.1 or newer|
|Nomad|0.12.3 or newer|0.12.3 or newer|

## Requirements

### Required software
All software is provided and run with docker. See the [Makefile](Makefile) for inspiration.

## Usage
The following command will run nifi registry in the [example/standalone](example/standalone) folder.
```sh
make up
```

### Verifying setup
You can verify that Nifi registry ran successful by checking the Nifi registry UI.

First create a proxy to connect with the Nifi registry service:
```
make proxy-nifi-reg
```
You can now visit the UI on [localhost:18080](http://127.0.0.1:18080/nifi-registry/).

### Providers
- [Nomad](https://registry.terraform.io/providers/hashicorp/nomad/latest/docs)
- [Vault](https://registry.terraform.io/providers/hashicorp/vault/latest/docs)

## Example 
The following code is an example of the Nifi registry module. For detailed information check the [example/standalone](/example/standalone).
```hcl-terraform
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
   container_image = "apache/nifi-registry:0.8.0"
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
}
```

## Inputs
| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| nomad\_datacenters | Nomad data centers | list(string) | ["dc1"] | yes |
| nomad\_namespace | [Enterprise] Nomad namespace | string | "default" | yes |
| nomad\_host\_volume | Nomad host volume | string | "persistence" | no |
| service\_name | nifi registry service name | string | "nifi-registry" | yes |
| host | Nifi registry host | string | "127.0.0.1" | yes |
| port | nifi registry container port | number | 18080 | yes |
| container\_image | nifi registry container image | string | "apache/nifi-registry:0.8.0" | yes |
| resource | Resource allocations for cpu and memory | obj(number, number)| { <br> cpu = 500, <br> memory = 1024 <br> } | no |
| resource_proxy | Resource allocations for proxy | obj(number, number)| { <br> cpu = 200, <br> memory = 128 <br> } | no |
| use\_host\_volume | Switch to enable or disable host volume | bool | false | no |
| use\_canary | Uses canary deployment for nifi | bool | false | no |

## Outputs
| Name | Description | Type |
|------|-------------|------|
| service\_name | nifi registry service name | string |

## Contributors

## License
This work is licensed under Apache 2 License. See [LICENSE](./LICENSE) for full details.
