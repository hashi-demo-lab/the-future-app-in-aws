locals {
  deployment_id = lower("${var.deployment_name}-${random_string.suffix.result}")
}

resource "random_string" "suffix" {
  length  = 8
  special = false
}


// HCP Packer

module "image_packer" {
  source = "./modules/hcp"

  region = var.region
}

// Amazon Web Services infrastructure
module "landingzone" {
  source  = "app.terraform.io/hashi-demos-apj/landingzone/aws"
  version = "0.2.4"

  enable_vpc            = var.enable_vpc
  enable_http_access    = var.enable_http_access
  enable_ssh_access     = var.enable_ssh_access
  enable_tgw            = var.enable_tgw
  enable_ssm            = var.enable_ssm
  region                = var.region
  owner                 = var.owner
  ttl                   = var.ttl
  deployment_name       = local.deployment_id
  vpc_cidr              = var.aws_vpc_cidr
  public_subnets        = var.aws_public_subnets
  private_subnets       = var.aws_private_subnets
  aws_key_pair_key_name = "${local.deployment_id}-${var.aws_key_pair_key_name}"
  ssh_pubkey            = var.ssh_pubkey
  workspace_type        = var.workspace_type
}

// Amazon Web Services EC2 Deployment

resource "aws_instance" "this" {
  ami                         = module.image_packer.cloud_image_id
  instance_type               = "t2.micro"
  subnet_id                   = module.landingzone.public_subnet_ids[0]
  vpc_security_group_ids      = ["${module.landingzone.security_group_http_id}", "${module.landingzone.security_group_ssh_id}"]
  associate_public_ip_address = true
  key_name                    = module.landingzone.aws_key_pair_name
  iam_instance_profile        = module.landingzone.ssm_instance_profile_name
  lifecycle {
    ignore_changes = all
  }

  tags = {
    owner = var.owner
    TTL   = var.ttl
    Name  = local.deployment_id
  }
}

resource "aws_ssm_document" "run_script_document" {
  name            = "${local.deployment_id}${var.workspace_type}"
  document_type   = "Command"
  document_format = "YAML"
  content         = templatefile("${path.root}/files/future.yaml", { description = "demo" })
}

resource "aws_ssm_association" "example" {
  name = aws_ssm_document.run_script_document.name

  targets {
    key    = "InstanceIds"
    values = [aws_instance.this.id]
  }
}