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

      config {
        image = "${image}"

      }
      template {
        data = <<EOH
         NIFI_REGISTRY_WEB_HTTP_HOST = "${host}"
         NIFI_REGISTRY_WEB_HTTP_PORT = "${port}"
         NIFI_REGISTRY_WEB_SHOULD_SEND_SERVER_VERSION = "true"
        EOH
        destination = "local/config.env"
        env = true
      }
      resources {
        cpu    = "${cpu}" # MHz
        memory = "${memory}" # MB
      }
    }
  }
}
