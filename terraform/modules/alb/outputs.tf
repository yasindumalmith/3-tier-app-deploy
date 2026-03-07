output "web_alb_dns_name" {
  description = "The DNS name of the Web Application Load Balancer"
  value       = aws_lb.alb_web.dns_name
}

output "web_alb_zone_id" {
  description = "The Route 53 zone ID of the Web Application Load Balancer"
  value       = aws_lb.alb_web.zone_id
}

output "app_alb_dns_name" {
  description = "The DNS name of the App Application Load Balancer"
  value       = aws_lb.alb_app.dns_name
}

output "web_target_group_arn" {
  description = "The ARN of the Web Target Group"
  value       = aws_lb_target_group.web_tg.arn
}

output "app_target_group_arn" {
  description = "The ARN of the App Target Group"
  value       = aws_lb_target_group.app_tg.arn
}
