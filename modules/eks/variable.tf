variable "subnet_id_1" {
  type = string
}

variable "subnet_id_2" {
  type = string
}

variable "subnet_id_3" {
  type = string
}

variable "instance_type" {
  type = string
  default = "t2.micro"
  description = "instance type for worker node"
}

variable "desired_size" {
  type = number
  default = 1
}
variable "max_size" {
  type = number
  default = 1
}
variable "min_size" {
  type = number
  default = 1
}