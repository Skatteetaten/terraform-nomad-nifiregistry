# Changelog
## [0.3.0 UNRELEASED]

### Added
- Customized Makefile to receive arguments for GitHub authentication #35
- Added secrets (GitHub user and GitHub personal token) to Vault by Ansible playbooks (`terraform-nomad-nifiregistry/dev/ansible` ) #35
- Added variables (repo and branch) to Consul Key Value Store #35 
- Created nomad-jobs for retrieving secrets from Vault and variables from Consul Key Value Store #33

### Updated 
- Updated tests with parameters #39
- Changed Ansible playbooks `01_put_secrets_vault.yml` and `02_put_variables_consul.yml`, such that they only execute for example/standalone_git. #43

## [0.2.1]

### Added
- Added README.md for example/standalone #22

### Changed
- Updated example/standalone/main.tf #30
- Updated example/README.md #22

## [0.2.0]

### Added
- Added an example `standalone_git` with a NiFi Registry container integrated with GIT version control #20

### Changed
- Update vagrant-box, `version = ">= 0.9, < 0.10"` #17
- Updated Makefile with option to for nomad to switch to use standalone or standalone with git #21
- updated example/standalone/main.tf with the same switch option #21
- Updated variables.tf and main.tf with new mode-variable #21
- Updated dev/ansible/01_run_terraform.yml #21
- Updated variables.tf and main.tf with new variables for git configuration #20

## [0.1.0]

### Added
- Create a working example for nifi registry #1
- Make up builds vagrant box with nifi registry #3
- Added make proxy-nifi-reg #3
- Added documentation #2

### Changed
- Removed unused files and examples with make template_init #6
- Updated README files #2
- Added port and host to output.tf #13


### Fixed

