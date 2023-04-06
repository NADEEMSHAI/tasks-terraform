locals {
  vpc_id      = aws_vpc.practice1.id
  internet_id = aws_internet_gateway.ntier.id
  anywhere    = "0.0.0.0/0"
  mysql_port  = 3306
  tcp         = "tcp"
  ssh_port    = 80
  http_port   = 443
  port_ssh    = 22
  port_http   = 0




}