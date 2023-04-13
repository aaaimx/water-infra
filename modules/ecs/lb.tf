# Terraform Module AWS Application Load Balancer (ALB)
module "alb_ecs" {
  source  = "terraform-aws-modules/alb/aws"
  version = "5.16.0"

  name = "${var.cluster_name}-ecs-alb"
  load_balancer_type = "application"
  vpc_id = var.vpc_id
  subnets = var.subnet_ids
  security_groups = [module.sg_alb_ecs.security_group_id ]
  http_tcp_listeners = [
   {
     port               = 80
     protocol           = "HTTP"
     target_group_index = 0
   }
  ]  
 target_groups = [
   {
     name_prefix      = "app1-"
     backend_protocol = "HTTP"
     backend_port     = 8000
     target_type      = "instance"
     health_check = {
       enabled             = true
       interval            = 30
       path                = "/"
       port                = 8000
       healthy_threshold   = 5
       unhealthy_threshold = 3
       timeout             = 6
       protocol            = "HTTP"
       matcher             = "200"
     }      
     protocol_version = "HTTP1"
   }     
 ]
}

# --- SG FOR APLICATION LOAD BALANCER - MODULE ----
module "sg_alb_ecs" {
    source = "../sg-instances"

    vpc_id = var.vpc_id
    instance_name = "${var.cluster_name}-alb-sg"

    sg_instances_rules = [
    {
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      description = "port HTTP"
      cidr_blocks = "0.0.0.0/0"
    },
    {
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      description = "port HTTPS"
      cidr_blocks = "0.0.0.0/0"
    },
  ]
}
