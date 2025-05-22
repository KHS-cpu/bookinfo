resource "kubernetes_service_account" "sa" {
  metadata {
    name      = "${var.name}-${var.version_deploy}"
    namespace = var.namespace
    labels = {
      account = var.name
    }
  }
  depends_on = [ var.namespace_dependency ]
}

resource "kubernetes_deployment_v1" "reviews_deploy" {
  metadata {
    name = "${var.name}-${var.version_deploy}"
    namespace = var.namespace
    labels = {
      app = var.name
      version = "${var.version_deploy}"
    }
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = var.name
        version = "${var.version_deploy}"
      }
    }

    template {
      metadata {
        annotations = {
            "prometheus.io/scrape" = "true"
            "prometheus.io/port" = "9080"
            "prometheus.io/path" = "/metrics"
        }
        labels = {
          app = var.name
          version = "${var.version_deploy}"
        }
      }

      spec {
        service_account_name = kubernetes_service_account.sa.metadata[0].name
        image_pull_secrets {
          name = var.secret_key
        }

      volume {
        name = "tmp"
        empty_dir {}
      }
        container {
          image = var.image
          image_pull_policy = "IfNotPresent"
          name  = var.name

          dynamic "env" {
            for_each = var.env_vars
            content {
            name  = env.value.name
            value = env.value.value
    }
  }

          port {
            container_port = 9080
          }
          volume_mount {
            name = "tmp"
            mount_path = "/tmp"
          }

        }
      }
    }
  }
  depends_on = [ var.secret_create ]
}

resource "kubernetes_service" "reviews_svc" {
  metadata {
    name = var.name
    namespace = var.namespace
    labels = {
      app = var.name
      service = var.name
    }
  }
  spec {
    selector = {
      app = var.name
    }
    port {
      port        = 9080
      target_port = 9080
      name = "http"
    }
  }
  depends_on = [ var.namespace_dependency, kubernetes_deployment_v1.reviews_deploy ]
}