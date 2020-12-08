output "nifi_reg_service_name" {
  description = "Nifi registry service name"
  value       = data.template_file.nomad_job_nifi_registry.vars.service_name
}

output "nifi_reg_port" {
  description = "Nifi registry port number"
  value       = data.template_file.nomad_job_nifi_registry.vars.port
}

output "nifi_reg_host" {
  description = "Nifi registry host"
  value       = data.template_file.nomad_job_nifi_registry.vars.host
}