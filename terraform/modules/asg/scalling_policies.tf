# web tier scalling policy 

resource "aws_autoscaling_policy" "web_scale_out" {
  name                      = "web_scale_out"
  autoscaling_group_name    = aws_autoscaling_group.web.name
  policy_type               = "StepScaling"
  adjustment_type           = "ChangeInCapacity"
  estimated_instance_warmup = 60

  step_adjustment {
    scaling_adjustment          = 1
    metric_interval_lower_bound = 0
  }
}

resource "aws_autoscaling_policy" "web_scale_in" {
  name                      = "web_scale_in"
  autoscaling_group_name    = aws_autoscaling_group.web.name
  policy_type               = "StepScaling"
  adjustment_type           = "ChangeInCapacity"
  estimated_instance_warmup = 60

  step_adjustment {
    scaling_adjustment          = -1
    metric_interval_lower_bound = 0
  }
}

resource "aws_cloudwatch_metric_alarm" "web_cpu_high" {
  alarm_name          = "web_cpu_high"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 60
  statistic           = "Average"
  threshold           = 70
  alarm_description   = "Alarm when web CPU utilization exceeds 70%"
  alarm_actions       = [aws_autoscaling_policy.web_scale_out.arn]
}

resource "aws_cloudwatch_metric_alarm" "web_cpu_low" {
  alarm_name          = "web_cpu_low"
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 60
  statistic           = "Average"
  threshold           = 30
  alarm_description   = "Alarm when web CPU utilization drops below 30%"
  alarm_actions       = [aws_autoscaling_policy.web_scale_in.arn]
}

# app tier scalling policy 

resource "aws_autoscaling_policy" "app_scale_out" {
  name                      = "app_scale_out"
  autoscaling_group_name    = aws_autoscaling_group.app.name
  policy_type               = "StepScaling"
  adjustment_type           = "ChangeInCapacity"
  estimated_instance_warmup = 60

  step_adjustment {
    scaling_adjustment          = 1
    metric_interval_lower_bound = 0
  }
}

resource "aws_autoscaling_policy" "app_scale_in" {
  name                      = "app_scale_in"
  autoscaling_group_name    = aws_autoscaling_group.app.name
  policy_type               = "StepScaling"
  adjustment_type           = "ChangeInCapacity"
  estimated_instance_warmup = 60

  step_adjustment {
    scaling_adjustment          = -1
    metric_interval_lower_bound = 0
  }
}

resource "aws_cloudwatch_metric_alarm" "app_cpu_high" {
  alarm_name          = "app_cpu_high"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 60
  statistic           = "Average"
  threshold           = 70
  alarm_description   = "Alarm when app CPU utilization exceeds 70%"
  alarm_actions       = [aws_autoscaling_policy.app_scale_out.arn]
}

resource "aws_cloudwatch_metric_alarm" "app_cpu_low" {
  alarm_name          = "app_cpu_low"
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 60
  statistic           = "Average"
  threshold           = 30
  alarm_description   = "Alarm when app CPU utilization drops below 30%"
  alarm_actions       = [aws_autoscaling_policy.app_scale_in.arn]
}
