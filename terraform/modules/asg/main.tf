# web launch template
resource "aws_launch_template" "web" {
  name_prefix = "${var.project_name}_web"

  image_id      = var.web_image_id
  instance_type = var.web_instance_type

  vpc_security_group_ids = [var.web_sg_id]
  key_name               = var.key_name

  user_data = base64encode(replace(base64decode(var.web_user_data_base64), "__APP_ALB_DNS__", aws_lb.app_alb.dns_name))

  monitoring {
    enabled = true
  }


  tag_specifications {
    resource_type = "instance"
    tags = {
      Name    = "web_${var.project_name}"
      Project = "vpc-alb"
      Tier    = "frontend"
    }
  }

}
