provider "kubernetes" {
  host                   = "https://192.168.58.2:8443"
  token                  = "eyJhbGciOiJSUzI1NiIsImtpZCI6Im9Fbm00aFFMclNQNVlGbV82SEZ2SlBDTmRyYWtLLTROTHpud0tzOVRzd1kifQ.eyJhdWQiOlsiaHR0cHM6Ly9rdWJlcm5ldGVzLmRlZmF1bHQuc3ZjLmNsdXN0ZXIubG9jYWwiXSwiZXhwIjoxNzMyMDUyMDIzLCJpYXQiOjE3MzE5NjU2MjMsImlzcyI6Imh0dHBzOi8va3ViZXJuZXRlcy5kZWZhdWx0LnN2Yy5jbHVzdGVyLmxvY2FsIiwianRpIjoiNGE3YzUxZDItZGVkNS00MWYxLThjYjUtZGRjZDNkMmE1NDYzIiwia3ViZXJuZXRlcy5pbyI6eyJuYW1lc3BhY2UiOiJrdWJlLXN5c3RlbSIsInNlcnZpY2VhY2NvdW50Ijp7Im5hbWUiOiJ0ZXJyYWZvcm0tdXNlciIsInVpZCI6ImJjZjRiNTNhLWM3YjgtNDJiMy05ZTYyLTM4ZWQyZGM0OTMwMiJ9fSwibmJmIjoxNzMxOTY1NjIzLCJzdWIiOiJzeXN0ZW06c2VydmljZWFjY291bnQ6a3ViZS1zeXN0ZW06dGVycmFmb3JtLXVzZXIifQ.yb_alsSccl0x6AaNHDs_2ElXXOkglB-0iJ1uDXy02-Sh32DZp_Dldn9ok9slAXla4fVrmBLrjMdlZkG2Lpf7RHAh3Z_o4dyHVdj9fXZU0ntuOPneNCua1JMfNujILIdL5oje13UYLfEexCC_y_IJY8mUS2p8FXoqyqhNiyZOTvW1XK4fo09mxp3vK63U3mImMoLZlW-f4EUhQW7NvmExmmj8iR2K6bfRoQsE9wvXMgULGnSj4K9Tb4FIiYtdzAMdEi88QJoyTXCIOvjbN1ZloAKryXlmSLptT8SiebI27lYKNsK_mHY8ycbjeyD19ivwPal8X20ZVwib3XfgEQwDtA"
  cluster_ca_certificate = file("./ca.crt")
}



resource "kubernetes_namespace" "example" {
  metadata {
    name = "example"
  }
}

resource "kubernetes_deployment" "nginx" {
  metadata {
    name      = "nginx-deployment"
    namespace = kubernetes_namespace.example.metadata[0].name  # Reference the created namespace
  }
  spec {
    replicas = 2
    selector {
      match_labels = { app = "nginx" }
    }
    template {
      metadata {
        labels = { app = "nginx" }
      }
      spec {
        container {
          name  = "nginx"
          image = "nginx:latest"
          port {
            container_port = 80
          }
        }
      }
    }
  }
}
