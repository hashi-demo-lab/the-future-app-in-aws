// generic variables

variable "region" {
  description = "AWS region"
  type        = string
  default     = ""
}

variable "owner" {
  description = "Resource owner identified using an email address"
  type        = string
  default     = ""
}

variable "ttl" {
  description = "Resource TTL (time-to-live)"
  type        = number
  default     = 48
}


variable "deployment_name" {
  description = "Deployment name, used to prefix resources"
  type        = string
  default     = ""
}

variable "aws_vpc_cidr" {
  description = "AWS VPC CIDR"
  type        = string
  default     = "10.200.0.0/16"
}

variable "aws_public_subnets" {
  description = "AWS public subnets"
  type        = list(any)
  default     = ["10.200.10.0/24"]
}

variable "aws_private_subnets" {
  description = "AWS private subnets"
  type        = list(any)
  default     = ["10.200.20.0/24"]
}

variable "address_space" {
  type        = string
  description = "The address space that is used by the virtual network. You can supply more than one address space. Changing this forces a new resource to be created."
  default     = "10.0.0.0/16"
}

variable "subnet_prefix" {
  description = "The address prefix to use for the subnet."
  type        = string
  default     = "10.0.10.0/24"
}

variable "instance_type" {
  description = "Specifies the AWS instance type."
  type        = string
  default     = "t2.micro"
}

variable "admin_username" {
  description = "Administrator user name for mysql"
  type        = string
  default     = "ubuntu"
}

variable "hcp_client_id" {
  description = "HCP client id"
  type        = string
  default     = ""
}

variable "hcp_client_secret" {
  description = "HCP client secret"
  type        = string
  default     = ""
}

variable "enable_vpc" {
  description = <<EOT
    (Optional) Enable AWS VPC creation.

    Default: true
  EOT
  type        = bool
  default     = true
}

variable "enable_http_access" {
  description = <<EOT
    (Optional) Enable http access to ec2 instance.

    Default: true
  EOT
  type        = bool
  default     = true
}

variable "enable_ssh_access" {
  description = <<EOT
    (Optional) Enable ssh access to ec2 instances.

    Default: true
  EOT
  type        = bool
  default     = true
}
variable "enable_tgw" {
  description = <<EOT
    (Optional) Enable AWS Transit Gateway.

    Default: false
  EOT
  type        = bool
  default     = false
}


variable "enable_ssm" {
  description = <<EOT
    (Optional) Enable AWS Systems Management.

    Default: true
  EOT
  type        = bool
  default     = true
}

variable "aws_key_pair_key_name" {
  description = "AWS key pair key name"
  type        = string
  default     = ""
}

variable "ssh_pubkey" {
  description = "SSH public key"
  type        = string
}


variable "workspace_type" {
  description = "Terraform Cloud workspace type"
  type        = string
}