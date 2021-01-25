job "${service_name}" {

  datacenters = ["${datacenters}"]
  type = "service"
  namespace = "${namespace}"
  update {
    max_parallel = 1
    health_check = "checks"
    min_healthy_time = "10s"
    healthy_deadline = "12m"
    progress_deadline = "15m"
    %{ if use_canary }
      canary            = 1
      auto_promote      = true
      auto_revert       = true
    %{ endif }
    stagger           = "30s"

  }

  group "servers" {
    count = 1
    network {
      mode = "bridge"
      port "expose_check" {
        to = -1
      }

    }
    service {
      name = "${service_name}"
      port = "${port}"
      connect {
        sidecar_service {
          proxy {
            expose {
              path {
                path            = "/nifi-registry/"
                protocol        = "http"
                local_path_port = ${port}
                listener_port   = "expose_check"
              }
            }
          }
        }
        sidecar_task {
         resources {
            cpu     = "${cpu_proxy}"
            memory  = "${memory_proxy}"
          }
        }
      }
      check {
        name     = "${service_name}-live"
        type     = "http"
        port     = "expose_check"
        path     = "/nifi-registry/"
        interval = "10s"
        timeout  = "2s"
      }
    }

    task "nifi-registry" {
      driver = "docker"

      vault {
        policies = "${vault_kv_policy_name}"
      }
      config {
        image = "${image}"

      }
      template {
destination = "secrets/.envs"
env = true
data        = <<EOF
{{ with secret "${vault_kv_path}" }}
FLOW_PROVIDER=git
GIT_REMOTE_URL={{ key "github/repo" }}
GIT_CHECKOUT_BRANCH={{ key "github/branch" }}
FLOW_PROVIDER_GIT_FLOW_STORAGE_DIRECTORY=${git_flow_storage_directory}
FLOW_PROVIDER_GIT_REMOTE_TO_PUSH=${git_remote_to_push}
FLOW_PROVIDER_GIT_REMOTE_ACCESS_USER="{{ .Data.data.${vault_kv_field_user} }}"
FLOW_PROVIDER_GIT_REMOTE_ACCESS_PASSWORD="{{ .Data.data.${vault_kv_field_password} }}"
{{ end }}
EOF
}
      resources {
        cpu    = "${cpu}" # MHz
        memory = "${memory}" # MB
      }
    }
  }
}
