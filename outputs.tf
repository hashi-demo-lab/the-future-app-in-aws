// generic outputs

output "deployment_id" {
  description = "Deployment identifier"
  value       = local.deployment_id
}

// aws outputs

output "website_url" {
  description = "AWS public url of app website"
  value       = "http://${aws_instance.this.public_dns}"
}
