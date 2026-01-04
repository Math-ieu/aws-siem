variable "region" {
  description = "AWS region"
  type        = string
  default     = "eu-west-3"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "m7i-flex.large"
}

variable "key_name" {
  description = "Name of the SSH key pair"
  type        = string
  default     = "wazuh-lab-key"
}

variable "allowed_ssh_ip" {
  description = "IP address allowed to SSH/RDP into instances"
  type        = string
  default     = "0.0.0.0/0" # Consider restricting this in production
}
