resource "aws_vpc" "toyota" {
    cidr_block = var.toyota.cidr_block
    tags = {
      "Name" = "toyota"
    } 
}
resource "aws_subnet" "tsubnet" {
    vpc_id = aws_vpc.toyota
    availability_zone = "${var.region}${var.toyota.subnets_names[count.index]}"
    count=lenght(var.toyota.subnets_names)
    cidr_block = cidrsubnet(var.toyota.cidr_block,8,count.index)

    tags = {
      Name = var.toyota.subnets_names[count.index]
    }

    depends_on = [
      aws_vpc.toyota
    ]

}
resource "aws_internet_gateway" "tig" {
    vpc_id = local.vpc_id
    tags = {
      Name = "tigmain"
    }
    depends_on = [
      aws_vpc.toyota.id
    ]
  
}
resource "aws_route_table" "private" {
  vpc_id = local.vpc_id

  route {
    cidr_block =local.anywhere
    gateway_id = local.gateway_id
  }

  tags = {
        Name = "private"
  }

  depends_on = [
    aws_subnet.tsubnet
  ]
}

resource "aws_route_table" "public" {
  vpc_id = local.vpc_id

  route {
    cidr_block =local.anywhere
    gateway_id = local.gateway_id
  }

  tags = {
        Name = "public"
  }

  depends_on = [
    aws_subnet.tsubnet
  ]
}

data "aws_instance" "foo" {
  instance_id = "i-instanceid"

  filter {
    name   = "image-id"
    values = ["ami-xxxxxxxx"]
  }

  filter {
    name   = "tag:Name"
    values = ["instance-name-tag"]
  }
}

resource "aws_route_table_association" "arta" {

  
}