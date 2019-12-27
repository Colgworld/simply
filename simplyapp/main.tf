provider "helm" {
}

resource "helm_release" "terrahelm" {
  name  = "terrahelm-example"
  repository = "https://www.colgworld.com/helm-charts/"
  chart = "terraform-example"
  # namespace = "simply-terraform"
}

# resource "helm_release" "nginx-ingress" {
#   name  = "nginx-ingress"
#   chart = "nginx-edge/nginx-ingress"

# }