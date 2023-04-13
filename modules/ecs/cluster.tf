resource "aws_ecs_cluster" "ecs_cluster" {
    name  = var.cluster_name
}

resource "aws_ecs_task_definition" "task_definition" {
  family                = "worker-terraform"
  container_definitions = jsonencode([
                          {
                            "essential": true,
                            "memory": 800,
                            "memoryReservation": 200,
                            "name": "aaaimx-api",
                            "cpu": 0,
                            "image": "066408755375.dkr.ecr.us-west-1.amazonaws.com/aaaimx-ecr:9268d28c38df96245fa9afab78c299883d73406a",
                            "executionRoleArn": null,
                            "stopTimeout": 10,
                            "environment": []
                            "portMappings": [
                                              {
                                                "hostPort": 8000,
                                                "protocol": "tcp",
                                                "containerPort": 8000
                                              }
                                            ],
                            "requiresCompatibilities": [
                                                        "EC2"
                                                      ],
                            "compatibilities": [
                                                  "EXTERNAL",
                                                  "EC2"
                                                ],
                          }
                        ])
}

# --- SG FOR APLICATION ECS - MODULE ----
module "sg_ecs" {
    source = "../sg-instances"

    vpc_id = var.vpc_id
    instance_name = "${var.cluster_name}-ecs-sg" 

    sg_instances_rules = [
    {
      from_port   = 0
      to_port     = 65535
      protocol    = "tcp"
      description = "containers ports"
      cidr_blocks = var.vpc_cidr
    },
  ]
}