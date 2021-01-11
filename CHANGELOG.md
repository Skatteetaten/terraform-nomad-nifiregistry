# Changelog

## [0.2.0 UNRELEASED]

### Added
- Add an example `standalone_git` with a NiFi Registry container integrated with GIT version control #20

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
- Removed unsused files and examples with make template_init #6
- Updated README files #2
- Added port and host to output.tf #13


### Fixed

