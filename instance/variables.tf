variable "subnet_ids" {
  description = "IDs of subnets to assign instances to."
  type        = list(string)
}

variable "resource_group_name" {
  description = "The name of the resource group."
  type        = string
}

variable "resource_group_location" {
  description = "The location of the resource group."
  type        = string
}

variable "security_group_id" {
  description = "ID of security group to attach instances to."
  type        = string
}

variable "public_key_openssh" {
  description = "Public key in OpenSSH format."
  type        = string
}

variable "instances_per_subnet" {
  description = "Number of instances per private subnet."
  type        = number
  default     = 1
}

variable "instance_type" {
  description = "Instance type for all instances."
  type        = string
  default     = "Standard_B1s"
}
