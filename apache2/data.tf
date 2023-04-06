data "aws_subnets" "web1" {
  filter {
    name   = "tag:Name"
    values = var.vpc_info.public_subnets

  }
  filter {
    name   = "vpc-id"
    values = [local.vpc_id]
  }
  depends_on = [
    aws_subnet.main
  ]
}
resource "aws_security_group" "web1" {
  name = "web"
  ingress {
    from_port   = local.ssh_port
    to_port     = local.ssh_port
    cidr_blocks = [local.anywhere]
    protocol    = local.tcp
  }
  ingress {
    from_port   = local.http_port
    to_port     = local.http_port
    cidr_blocks = [local.anywhere]
    protocol    = local.tcp
  }
  ingress {
    from_port   = local.port_ssh
    to_port     = local.port_ssh
    cidr_blocks = [local.anywhere]
    protocol    = local.tcp
  }
  egress {
    from_port   = local.port_http
    to_port     = local.port_http
    cidr_blocks = [local.anywhere]
    protocol    = "-1"
  }
  vpc_id = local.vpc_id

  tags = {
    Name = "web"
  }
  depends_on = [
    aws_subnet.main
  ]
}


data "aws_ami_ids" "ubuntu" {
  owners = ["099720109477"]
  filter {
    name   = "description"
    values = ["Canonical, Ubuntu, 22.04 LTS, amd64 jammy image build on 2023-03-25"]
  }

}

resource "aws_key_pair" "mykey" {
  key_name   = "nadeem"
  public_key = file("~/.ssh/id_rsa.pub")
}

resource "aws_instance" "apache2" {
  ami                         = data.aws_ami_ids.ubuntu.ids[0]
  associate_public_ip_address = true
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.main[0].id
  vpc_security_group_ids      = [aws_security_group.web1.id]
  user_data                   = filebase64("apache2.sh")
  key_name                    = "nadeem"
  tags = {
    Name = "apache2"
  }
  depends_on = [
    aws_security_group.web1,
    aws_subnet.main

  ]

}




resource "aws_lb_target_group" "targetg" {
  name     = "lb-target"
  port     = 80
  protocol = "HTTP"
  vpc_id   = local.vpc_id
  depends_on = [
    aws_instance.apache2
  ]
}

resource "aws_lb" "load1" {
  name               = "testloadbalancer"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.web1.id]
  subnets            = [data.aws_subnets.web1.ids[0], data.aws_subnets.web1.ids[1]]
  ip_address_type    = "ipv4"



  enable_deletion_protection = false

  tags = {
    Environment = "production"
  }
}


