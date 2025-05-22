module "details" {
  source     = "./modules/bookinfo_service"
  name       = "details"
  namespace  = "details"
  version_deploy    = "v1"
  image      = "684909422213.dkr.ecr.ap-southeast-1.amazonaws.com/khs:details-custom-v1"
  env_vars = [
    {
      name  = "PRODUCTPAGE_HOSTNAME"
      value = "productpage.productpage"
    }
  ]
  namespace_dependency = kubernetes_namespace_v1.bookinfo_ns
  secret_create = kubernetes_secret_v1.ecr_secret
}

module "ratings" {
  source     = "./modules/bookinfo_service"
  name       = "ratings"
  namespace  = "ratings"
  version_deploy    = "v1"
  image      = "684909422213.dkr.ecr.ap-southeast-1.amazonaws.com/khs:ratings-custom-v1"
  env_vars = []

  
  namespace_dependency = kubernetes_namespace_v1.bookinfo_ns
  secret_create = kubernetes_secret_v1.ecr_secret
}

module "reviews1" {
  source     = "./modules/reviews"
  name       = "reviews-v1"
  namespace  = "reviews"
  version_deploy    = "v1"
  image      = "684909422213.dkr.ecr.ap-southeast-1.amazonaws.com/khs:reviews-custom-v1"
  env_vars = [
    {
      name  = "RATINGS_HOSTNAME"
      value = "ratings.ratings"
    },
    {
      name  = "LOG_DIR"
      value = "/tmp/logs"
    }
  ]
  namespace_dependency = kubernetes_namespace_v1.bookinfo_ns
  secret_create = kubernetes_secret_v1.ecr_secret
}

module "reviews2" {
  source     = "./modules/reviews"
  name       = "reviews-v2"
  namespace  = "reviews"
  version_deploy    = "v2"
  image      = "684909422213.dkr.ecr.ap-southeast-1.amazonaws.com/khs:reviews-custom-v2"
  env_vars = [
    {
      name  = "RATINGS_HOSTNAME"
      value = "ratings.ratings"
    },
    {
      name  = "LOG_DIR"
      value = "/tmp/logs"
    }
  ]
  namespace_dependency = kubernetes_namespace_v1.bookinfo_ns
  secret_create = kubernetes_secret_v1.ecr_secret
}

module "reviews3" {
  source     = "./modules/reviews"
  name       = "reviews"
  namespace  = "reviews"
  version_deploy    = "v3"
  image      = "684909422213.dkr.ecr.ap-southeast-1.amazonaws.com/khs:reviews-custom-v3"
  env_vars = [
    {
      name  = "RATINGS_HOSTNAME"
      value = "ratings.ratings"
    },
    {
      name  = "LOG_DIR"
      value = "/tmp/logs"
    }
  ]
  namespace_dependency = kubernetes_namespace_v1.bookinfo_ns
  secret_create = kubernetes_secret_v1.ecr_secret
}

module "productpage" {
  source     = "./modules/productpage"
  name       = "productpage"
  namespace  = "productpage"
  version_deploy    = "v1"
  image      = "684909422213.dkr.ecr.ap-southeast-1.amazonaws.com/khs:productpage-custom-new"
  env_vars = [
    {
      name  = "DETAILS_HOSTNAME"
      value = "details.details"
    },
    {
      name  = "REVIEWS_HOSTNAME"
      value = "reviews.reviews"
    }
  ]
  namespace_dependency = kubernetes_namespace_v1.bookinfo_ns
  secret_create = kubernetes_secret_v1.ecr_secret
}
