provider "helm" {
}

resource "helm_release" "terraform-example" {
  name  = "terraform-example"
  chart = "terraform-example"
  namespace = "terraform-example-namespace-namespace"

    values = [
    "values.yaml"
  ]
}