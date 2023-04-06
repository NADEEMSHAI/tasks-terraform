resource "aws_security_group" "database" {
  name = "mysql"
  ingress {
    cidr_blocks = [var.vpc_info.cidr_vpc]
    from_port   = local.mysql_port
    to_port     = local.mysql_port
    protocol    = local.tcp

  }
  tags = {
    Name = "mysql"

  }
  vpc_id = local.vpc_id

  depends_on = [
    aws_subnet.main
  ]
}


