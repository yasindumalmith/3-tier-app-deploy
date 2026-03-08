# web launch template
resource "aws_launch_template" "web" {
  name_prefix = "${var.project_name}_web"

  image_id      = var.web_image_id
  instance_type = var.web_instance_type

  vpc_security_group_ids = [var.web_sg_id]
  key_name               = var.key_name

  user_data = base64encode(replace(file("${path.root}/../web_startup.sh"), "__REPLACE_ME_ALB_DNS__", var.app_alb_dns_name))


  monitoring {
    enabled = true
  }

  iam_instance_profile {
    name = aws_iam_instance_profile.app_profile.name
  }

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name    = "web_${var.project_name}"
      Project = var.project_name
      Tier    = "frontend"
    }
  }
}

# web auto scaling group
resource "aws_autoscaling_group" "web" {
  name                      = "${var.project_name}_web_asg"
  vpc_zone_identifier       = var.web_private_subnets
  min_size                  = 2
  max_size                  = 5
  desired_capacity          = 2
  health_check_type         = "EC2"
  health_check_grace_period = 300

  launch_template {
    id      = aws_launch_template.web.id
    version = "$Latest"
  }

  target_group_arns = [var.web_target_group_arn]

  tag {
    key                 = "Name"
    value               = "web_${var.project_name}"
    propagate_at_launch = true
  }

  tag {
    key                 = "Project"
    value               = var.project_name
    propagate_at_launch = true
  }

  tag {
    key                 = "Tier"
    value               = "frontend"
    propagate_at_launch = true
  }
}

# S3 access policy
resource "aws_iam_policy" "s3_access_policy" {
  name        = "s3_access_policy_${var.project_name}"
  description = "Allow EC2 to sync from S3"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "s3:GetObject",
          "s3:ListBucket"
        ]
        Effect = "Allow"
        Resource = [
          "arn:aws:s3:::3-tier-s3-bucket-yasa",
          "arn:aws:s3:::3-tier-s3-bucket-yasa/*"
        ]
      }
    ]
  })
}

# attach policy to role
resource "aws_iam_role_policy_attachment" "s3_attach" {
  role       = aws_iam_role.app_role.name
  policy_arn = aws_iam_policy.s3_access_policy.arn
}

# 

resource "aws_iam_role" "app_role" {
  name = "app_role_${var.project_name}"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })
}

# resource "aws_iam_policy" "secrets_policy" {
#  name        = "secrets_policy_${var.project_name}"
#  description = "Allow access to secrets manager"

#  policy = jsonencode({
#    Version = "2012-10-17"
#    Statement = [
#      {
#        Action = [
#          "secretsmanager:GetSecretValue"
#        ]
#        Effect   = "Allow"
#        Resource = "*"
#      }
#    ]
#  })
#}

#resource "aws_iam_role_policy_attachment" "secrets_attach" {
#  role       = aws_iam_role.app_role.name
#  policy_arn = aws_iam_policy.secrets_policy.arn
#}

resource "aws_iam_instance_profile" "app_profile" {
  name = "app_profile_${var.project_name}"
  role = aws_iam_role.app_role.name
}

# app launch template
resource "aws_launch_template" "app" {
  name_prefix = "${var.project_name}_app"

  image_id      = var.app_image_id
  instance_type = var.app_instance_type

  vpc_security_group_ids = [var.app_sg_id]
  key_name               = var.key_name

  user_data = base64encode(
    replace(
      replace(
        replace(
          file("${path.root}/../app_startup.sh"),
          "__DB_ENDPOINT__", var.db_endpoint
        ),
        "__DB_USER__", var.db_username
      ),
      "__DB_PASS__", var.db_password
    )
  )

  monitoring {
    enabled = true
  }

  iam_instance_profile {
    name = aws_iam_instance_profile.app_profile.name
  }

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name    = "app_${var.project_name}"
      Project = var.project_name
      Tier    = "backend"
    }
  }
}

# app auto scaling group
resource "aws_autoscaling_group" "app" {
  name                      = "${var.project_name}_app_asg"
  vpc_zone_identifier       = var.app_private_subnets
  min_size                  = 2
  max_size                  = 5
  desired_capacity          = 2
  health_check_type         = "EC2"
  health_check_grace_period = 300

  launch_template {
    id      = aws_launch_template.app.id
    version = "$Latest"
  }

  target_group_arns = [var.app_target_group_arn]

  tag {
    key                 = "Name"
    value               = "app_${var.project_name}"
    propagate_at_launch = true
  }

  tag {
    key                 = "Project"
    value               = var.project_name
    propagate_at_launch = true
  }

  tag {
    key                 = "Tier"
    value               = "backend"
    propagate_at_launch = true
  }
}
