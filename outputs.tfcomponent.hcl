# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

output "intance_ids" {
  type        = list(list(string))
  description = "Azure VM IDs"
  value       = [for x in component.instance : tolist(x.instance_ids)]
}

output "intance_private_ips" {
  type        = list(list(string))
  description = "EC2 instance Private DNS names"
  value       = [for x in component.instance : tolist(x.private_ips)]
}
