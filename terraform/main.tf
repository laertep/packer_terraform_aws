resource "aws_instance" "server" {
  count = "2" 
  ami           = var.ami
  instance_type = var.instance_type
  
  #key_name = "testepacker"
  vpc_security_group_ids = [aws_security_group.allow_ssh_http.id] //esta linha vinculada ao acesso.tf para direconar uma no security group - importante
  
  tags = {
    Name        = var.name
    Environment = var.env
    Provisioner = "Terraform"
  }
}


resource "aws_security_group" "lb_sg" {
  name_prefix = "lb-sg"
  ingress {
    from_port   = 80 # altere para a porta desejada
    to_port     = 80 # altere para a porta desejada
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # permita acesso de qualquer endereço IP

   }
  # Adicione mais regras de ingress se necessário
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]

    
  }
}


resource "aws_lb" "serverlb" {
  name               = "serverlb" # altere para o nome desejado
  internal           = false # define se o LB é interno ou externo
  load_balancer_type = "application" # altere para o tipo desejado (application ou network)
  
  
  security_groups = [
    aws_security_group.lb_sg.id,
  ]

  subnets = [
    "subnet-0f7bf6dc1fb55d724",
    "subnet-0139e2867cad5f673",
  ] # altere para as subnets desejadas

  tags = {
    Name = "servidor-lb" # altere para o nome desejado
  }
}


resource "aws_lb_listener" "serverlb" {
  load_balancer_arn = aws_lb.serverlb.arn
  port              = "80" # altere para a porta desejada
  protocol          = "HTTP" # alter
 
default_action {
    type = "fixed-response"

    fixed_response {
     content_type = "text/plain"
     message_body = "Fixed response content"
     status_code  = "200"
   }
  }
}


resource "aws_lb_target_group" "srvtg" {
  name_prefix = "srvtg" # altere para o nome desejado
  port        = 80 # altere para a porta desejada
  protocol    = "HTTP" # altere para o protocolo desejado (HTTP ou HTTPS)
  vpc_id = "vpc-0a7b5957c225bf53c"

  health_check {
    interval            = 30
    path                = "/"
    port                = "traffic-port"
    protocol            = "HTTP"
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }

  tags = {
   Name = "srvtg" # altere para o nome desejado
  }
}

//Recurso para fazer o balanceamento EC2
//resource "aws_elb" "server" {
  //name               = "server-elb"
  //security_groups    = [aws_security_group.allow_ssh_http.id]
  //availability_zones = ["us-east-1a", "us-east-1b"]
  //#subnets            = aws_subnet.example.*.id
  //listener {
    //lb_port           = 80
    //instance_protocol = "HTTP"
    //instance_port     = 80
    //lb_protocol       = "HTTP"
  //}
//}




  
