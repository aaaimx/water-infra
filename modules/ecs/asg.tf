resource "aws_launch_configuration" "ecs_launch_config" {
    image_id             = "ami-01265f4d4e8b501fe"
    iam_instance_profile = data.aws_iam_role.ecs_agent.name
    security_groups      = [ module.sg_ecs.security_group_id ]
    user_data            = "#!/bin/bash\necho ECS_CLUSTER=${var.cluster_name} >> /etc/ecs/ecs.config"
    instance_type        = "t3.medium"
}

resource "aws_autoscaling_group" "failure_analysis_ecs_asg" {
    name                      = "asg"
    vpc_zone_identifier       = var.subnet_ids
    launch_configuration      = aws_launch_configuration.ecs_launch_config.name

    desired_capacity          = 1
    min_size                  = 1
    max_size                  = 3
    health_check_grace_period = 300
    health_check_type         = "EC2"

    target_group_arns = module.alb_ecs.target_group_arns
}