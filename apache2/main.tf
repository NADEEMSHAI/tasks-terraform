resource "aws_vpc" "practice1" {

  cidr_block = var.vpc_info.cidr_vpc

  tags = {

    Name = "practice1"
  }
}
# 
resource "aws_subnet" "main" {
  vpc_id            = local.vpc_id
  cidr_block        = cidrsubnet(var.vpc_info.cidr_vpc, 8, count.index)
  count             = length(var.vpc_info.subnets_names)
  availability_zone = "${var.region}${var.vpc_info.subnets_zones[count.index]}"
  tags = {
    Name = var.vpc_info.subnets_names[count.index]
  }
  depends_on = [
    aws_vpc.practice1
  ]
}

resource "aws_internet_gateway" "ntier" {
  vpc_id = local.vpc_id
  tags = {
    Name = "internet"
  }
  depends_on = [
    aws_vpc.practice1

  ]
}

resource "aws_route_table" "private" {
  vpc_id = local.vpc_id

  tags = {
    Name = "private"
  }

}

resource "aws_route_table" "public" {
  vpc_id = local.vpc_id
  route {
    cidr_block = local.anywhere
    gateway_id = local.internet_id
  }
  tags = {
    Name = "public"
  }

}
data "aws_subnets" "public" {
  filter {
    name   = "tag:Name"
    values = var.vpc_info.public_subnets
  }
  filter {
    name   = "vpc-id"
    values = [aws_vpc.practice1.id]
  }

  depends_on = [
    aws_subnet.main
  ]
}

data "aws_subnets" "private" {
  filter {
    name   = "tag:Name"
    values = var.vpc_info.private_subnets
  }
  filter {
    name   = "vpc-id"
    values = [aws_vpc.practice1.id]
  }
  depends_on = [
    aws_subnet.main
  ]
}



resource "aws_route" "igw" {
  gateway_id             = aws_internet_gateway.ntier.id
  destination_cidr_block = "0.0.0.0/0"
  route_table_id         = aws_route_table.public.id
  depends_on = [
    aws_internet_gateway.ntier
  ]
}

resource "aws_route_table_association" "public_association" {
  route_table_id = aws_route_table.public.id

  subnet_id = data.aws_subnets.public.ids[count.index]
  count     = length(var.vpc_info.public_subnets)
  depends_on = [
    aws_vpc.practice1
  ]
}

# resource "aws_route_table_association" "public_association2" {
#   route_table_id = aws_route_table.public.id

#   subnet_id = aws_subnet.main[5].id 
#   count     = length(var.vpc_info.public_subnets)
#   depends_on = [
#     aws_vpc.practice1
#   ]
# }

resource "aws_route_table_association" "private_association" {
  route_table_id = aws_route_table.private.id

  subnet_id = data.aws_subnets.private.ids[count.index]
  count     = length(var.vpc_info.private_subnets)
  depends_on = [
    aws_vpc.practice1
  ]
}
