resource "aws_route53_record" "app_dns" {
  zone_id = var.zone_id
  name    = var.dns_name
  type    = "CNAME"
  ttl     = "300"

  records = [
    aws_alb.app_lb.dns_name,
  ]
}