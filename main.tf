resource "kubernetes_deployment" "example" {
  metadata {
    name = "terraform-example"
    labels = {
      test = "MyApp1"
    }
  }

  spec {
    replicas = 3

    selector {
      match_labels = {
        test = "MyApp1"
      }
    }

    template {
      metadata {
        labels = {
          test = "MyApp1"
        }
      }

      spec {
        container {
          image = "colgworld/simplychallenge:latest"
          name  = "example"

          resources {
            limits {
              cpu    = "0.5"
              memory = "512Mi"
            }
            requests {
              cpu    = "250m"
              memory = "50Mi"
            }
          }

          liveness_probe {
            http_get {
              path = "/"
              port = 8080

              http_header {
                name  = "X-Custom-Header"
                value = "Awesome"
              }
            }

            initial_delay_seconds = 3
            period_seconds        = 3
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "example" {
  metadata {
    name = "terraform-example"
  }
  spec {
    selector = {
      app = "${kubernetes_pod.example.metadata.0.labels.app}"
    }
    session_affinity = "ClientIP"
    port {
      name        = "http"
      port        = 8080
      target_port = 3000
    }

    type = "LoadBalancer"
  }
}

resource "kubernetes_ingress" "example" {
  metadata {
    name = "terraform-example"
  }

  spec {
    backend {
      service_name = "terraform-example"
      service_port = 8080
    }

    rule {
      http {
        path {
          backend {
            service_name = "terraform-example"
            service_port = 8080
          }

          path = "/"
        }
      }
    }

    tls {
      secret_name = "tls-secret"
    }
  }
}

resource "kubernetes_pod" "example" {
  metadata {
    name = "terraform-example"
    labels = {
      app = "MyApp1"
    }
  }

  spec {
    container {
      image = "colgworld/simplychallenge:latest"
      name  = "example"

      port {
        container_port = 3000
      }
    }
  }
}