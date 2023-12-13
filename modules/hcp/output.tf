output "cloud_image_id" {
  description = "cloud image id"
  value       = data.hcp_packer_image.aws-ubuntu-apache.cloud_image_id

}
