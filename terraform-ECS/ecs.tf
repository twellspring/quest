resource "aws_kms_key" "quest" {
  description             = "${var.prefix} ecs kms key"
  deletion_window_in_days = 7
}

resource "aws_cloudwatch_log_group" "quest" {
  name = "${var.prefix}"
}

resource "aws_ecs_cluster" "quest" {
  name = "${var.prefix}_quest"

  configuration {
    execute_command_configuration {
      kms_key_id = aws_kms_key.quest.arn
      logging    = "OVERRIDE"

      log_configuration {
        cloud_watch_encryption_enabled = true
        cloud_watch_log_group_name     = aws_cloudwatch_log_group.quest.name
      }
    }
  }
}


resource "aws_ecs_task_definition" "quest" {
  family                   = var.prefix
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  memory                   = var.ecs_memory
  cpu                      = var.ecs_cpu
  execution_role_arn       = "${aws_iam_role.ecs_task_role.arn}"
  container_definitions    = <<DEFINITION
  [
    {
      "name": "${var.prefix}_quest",
      "image": "${aws_ecr_repository.rearc_quest.repository_url}:latest",
      "memory":${var.ecs_memory},
      "cpu": ${var.ecs_cpu},
      "networkMode": "awsvpc",
      "portMappings": [
        {
          "containerPort": 3000,
          "hostPort": 3000
        }
      ],
      "logConfiguration": {
        "logDriver": "awslogs",
        "options": {
            "awslogs-create-group": "true",
            "awslogs-group": "rearc",
            "awslogs-region": "us-west-2",
            "awslogs-stream-prefix": "quest"
        }
      },
      "environment": [
      {
        "name": "DUMMY",
        "value": "Sensational"
      }
    ]
    }
  ]
  DEFINITION
}

resource "aws_ecs_service" "quest" {
  name            = "${var.prefix}_service"
  cluster         = "${aws_ecs_cluster.quest.id}"
  task_definition = "${aws_ecs_task_definition.quest.arn}"
  launch_type     = "FARGATE"
  desired_count   = 1

  network_configuration {
    subnets = module.vpc.public_subnets
    assign_public_ip = true
    security_groups = [aws_security_group.quest.id]
  }
}
