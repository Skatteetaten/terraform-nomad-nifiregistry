output "nifi_reg_service_name" {
  description = "Nifi registry service name"
  value       = data.template_file.nomad_job_nifi_registry.vars.service_name
}