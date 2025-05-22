variable "name" {
  description = "This is the name of microservice"
  type = string
}

variable "namespace" {
  description = "This is the name of microservice namespace"
  type = string
}

variable "version_deploy" {
  description = "This is the name of deployment version"
  type = string
}

variable "secret_key" {
  description = "This is the name of name of secret key"
  type = string
  default = "ecr-secret"
}

variable "image" {
  description = "This is the name of ecr image"
  type = string
}

variable "env_vars" {
  description = "List of environment variables"
  type = list(object({
    name  = string
    value = string
  }))
}

variable "namespace_dependency" {
  description = "Dependency to ensure namespaces exist before resource creation"
  type        = any
}

variable "secret_create" {
  description = "Dependency to ensure secret exist before resource creation"
  type        = any
}
