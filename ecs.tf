resource "aws_ecs_cluster" "pranavi_cluster" {
  name = "staging-cluster-pranavi"
}

resource "aws_ecs_task_definition" "pranavi_backend" {
  family                   = "backend-task"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "256"
  memory                   = "512"

  container_definitions = jsonencode([{
    name      = "backend"
    image     = "102345621.dkr.ecr.ca-central-1.amazonaws.com/backend:latest" 
    essential = true
    portMappings = [{
      containerPort = 5000
      hostPort      = 5000
    }]
    environment = [
      { name = "NODE_ENV", value = "staging" },
      { name = "API_KEY", value = "your-api-key" }
    ]
    logConfiguration = {
      logDriver = "awslogs"
      options = {
        awslogs-group         = "/ecs/backend-task"
        awslogs-region        = "ca-central-1"
        awslogs-stream-prefix = "ecs"
      }
    }
  }])
}

# ECS Service (Backend)
resource "aws_ecs_service" "ecs_pranavi_backend_service" {
  name            = "ecs_pranavi_backend-service"
  cluster         = aws_ecs_cluster.pranavi_cluster.id
  task_definition = aws_ecs_task_definition.pranavi_backend.arn
  desired_count   = 2  

  launch_type = "FARGATE"

  network_configuration {
    subnets         = [aws_subnet.public.id]  
    security_groups = [aws_security_group.alb_sg_pranavi.id]
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.backend_tg.arn
    container_name   = "backend"
    container_port   = 5000
  }

  deployment_minimum_healthy_percent = 50
  deployment_maximum_percent         = 200

  depends_on = [aws_lb_listener.https_listener]
}

# ECS Task Definition (frontend_pranavi)
resource "aws_ecs_task_definition" "frontend_pranavi_task" {
  family                   = "frontend_pranavi-task"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "256"
  memory                   = "512"

  container_definitions = jsonencode([{
    name      = "frontend_pranavi"
    image     = "102345621.dkr.ecr.us-east-1.amazonaws.com/frontend_pranavi:latest" # Replace with your ECR image
    essential = true
    portMappings = [{
      containerPort = 3000
      hostPort      = 3000
    }]
    environment = [
      { name = "REACT_APP_API_URL", value = "https://your-api-url" }
    ]
    logConfiguration = {
      logDriver = "awslogs"
      options = {
        awslogs-group         = "/ecs/frontend_pranavi-task"
        awslogs-region        = "us-east-1"
        awslogs-stream-prefix = "ecs"
      }
    }
  ]])
}

# ECS Service (frontend_pranavi)
resource "aws_ecs_service" "frontend_pranavi_service" {
  name            = "frontend_pranavi-service"
  cluster         = aws_ecs_cluster.staging_cluster.id
  task_definition = aws_ecs_task_definition.frontend_pranavi_task.arn
  desired_count   = 2  # Number of tasks

  launch_type = "FARGATE"

  network_configuration {
    subnets         = [aws_subnet.public.id]
    security_groups = [aws_security_group.alb_sg.id]
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.frontend_pranavi_tg.arn
    container_name   = "frontend_pranavi"
    container_port   = 3000
  }

  deployment_minimum_healthy_percent = 50
  deployment_maximum_percent         = 200

  depends_on = [aws_lb_listener.https_listener]
}
