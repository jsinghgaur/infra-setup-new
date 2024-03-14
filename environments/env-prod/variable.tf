variable "aws_region" {
  type    = string
  default = "ap-south-1"
}
variable "my_project_name" {
  type    = string
  default = "prod-project"
}
variable "eks_cluster_name" {
  type = string
  default = "prod-cluster"
}