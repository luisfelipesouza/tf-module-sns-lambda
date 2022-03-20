variable "lambda_handler"{
    type = string
    default = "index.handler"
}
variable "lambda_runtime"{
    type = string
    default = "nodejs14.x"
}
variable "lambda_timeout"{
    type = number
    default = 20
}
variable "env_variables"{
    type = map
    default = {}
}
variable "region"{
    type = string
}
variable "environment" {
  type = string
}
variable "application" {
  type = string
}
variable "cost-center" {
  type = string
}
variable "deployed-by" {
  type = string
}
variable "git_url" {
    type = string
}
variable "git_version" {
    type = string
    default = "1"
}