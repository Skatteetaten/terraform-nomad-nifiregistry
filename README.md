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
The following command will run nifi registry in the [example/standalone_git](example/standalone_git) folder. (__NOTE!__ Please read [README.md](example/standalone_git/README.md) before executing the example)
```sh
make up repo=<GitHub-repository> branch=<branch to checkout and track> user=<GitHub username> token=<personal token from GitHub> 
```
and
```sh
make up-standalone
```
will run nifi registry in the [example/standalone](example/standalone) folder.

### Verifying setup
You can verify that Nifi registry ran successful by checking the Nifi registry UI.

First create a proxy to connect with the Nifi registry service:
```
make proxy-nifi-reg
```
You can now visit the UI on [http://127.0.0.1:18080/nifi-registry/](http://127.0.0.1:18080/nifi-registry/).

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
   mode            = "standalone"
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
| service\_name | nifi registry service name | string | "nifi-registry" | yes |
| host | Nifi registry host | string | "127.0.0.1" | yes |
| port | Nifi registry container port | number | 18080 | yes |
| mode | Switch for Nomad to use standalone or standalone with git deployment | string | "standalone" | no |
| container\_image | nifi registry container image | string | "apache/nifi-registry:0.8.0" | yes |
| resource | Resource allocations for cpu and memory | obj(number, number)| { <br> cpu = 500, <br> memory = 1024 <br> } | no |
| resource_proxy | Resource allocations for proxy | obj(number, number)| { <br> cpu = 200, <br> memory = 128 <br> } | no |
| use\_canary | Uses canary deployment for nifi | bool | false | no |
| vault_secret.use_vault_provider | Set if want to access secrets from Vault | bool | true | no |
| vault_secret.vault_kv_policy_name | Vault policy name to read secrets | string | "kv-secret" | no |
| vault_secret.vault_kv_path | Path to the secret key in Vault | string | "secret/data/minio" | no |
| vault_secret.vault_kv_field_access_key | Secret key name in Vault kv path | string | "access_key" | no |
| vault_secret.vault_kv_field_secret_key | Secret key name in Vault kv path | string | "secret_key" | no |
| git_remote_url  |Git integration: URL of the remote git repository. | string | " " | yes|
| git_checkout_branch  |Git integration: Branch to checkout and track. | string | " " | yes|
| git_flow_storage_directory  |Git integration: Default value is set by image, original default value was "./flow-storage". This variable is used in clone script as a destination directory for clone. It is also used in NiFi Registry configuration.| string |/opt/nifi-registry/flow-storage  | yes|
| git_remote_to_push  |Git integration: This variable is used in clone script to set origin name using `-o, --origin <name> use <name> instead of 'origin' to track upstream`. It is also used in NiFi Registry configuration.| string |origin | yes|
| git_access_user  |Git integration: Username|  string | " " | yes|
| git_access_password  |Git integration: Password|  string | " " | yes|
| git_user_name  |Git integration: Developer|string |nifi-registry  |no|
| git_user_email |Git integration: Developer email| string |nifi-registry@localhost|no|

## Outputs
| Name | Description | Type |
|------|-------------|------|
| nifi\_reg\_service\_name | nifi registry service name | string |
| nifi\_reg\_port | nifi registry port number | number |
| nifi\_reg\_host | nifi registry host | string |

## Contributors

## License
This work is licensed under Apache 2 License. See [LICENSE](./LICENSE) for full details.
