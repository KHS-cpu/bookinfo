resource "kubernetes_namespace_v1" "bookinfo_ns" {
  for_each =   toset(["details", "ratings", "productpage", "reviews"])
  metadata {
      name = each.key
      labels = {
      name = each.key
    }
  }
}

# data "external" "ecr_password" {
#   program = ["bash", "${path.module}/password.sh"]
# }


data "aws_ecr_authorization_token" "ecr_token" {}

resource "kubernetes_secret_v1" "ecr_secret" {
  for_each = toset(["details", "ratings", "reviews", "productpage"])
  metadata {
    name = var.secret_key
    namespace = each.key
  }
  type = "kubernetes.io/dockerconfigjson"

  data = {
    ".dockerconfigjson" = (jsonencode({
      auths = {
        "684909422213.dkr.ecr.ap-southeast-1.amazonaws.com/khs" = {
        #   username = "AWS"
        #   password = data.aws_ecr_authorization_token.ecr_token.authorization_token
          auth     = "${data.aws_ecr_authorization_token.ecr_token.authorization_token}"
        }
      }
    }))
  }
  depends_on = [ kubernetes_namespace_v1.bookinfo_ns ]
}
