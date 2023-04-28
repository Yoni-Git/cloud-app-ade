output "app_url" {
  description = "The URL of the deployed application"
  value       = "http://${aws_route53_record.app_dns.fqdn}"
}
