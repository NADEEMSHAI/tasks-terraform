resource "aws_vpc" "ntier1" {
  cidr_block = var.info_vpc.cidr_block.count.index
  tags = {
    Name = "ntier1"
  }
}

resource "aws_vpc" "jtier1" {
  cidr_block = var.info_vpc.cidr_block.count.index
  tags = {
    Name = "jtier1"
  }
}


resource "aws_subnet" "ntier1" {
  vpc_id            = aws_vpc(var.info_vpc.aws_vpc[0].count.index.id)
  count             = length(var.info_vpc.subnets_names)
  cidr_block        = cidrsubnet(var.info_vpc.cidr_block[0], 8, count.index)
  availability_zone = "${var.region}${var.info_vpc.subnets_zones[count.index]}"
  tags = {
    Name = var.info_vpc.subnets_names[count.index]

  }
  depends_on = [
    aws_vpc.ntier1
  ]
}


resource "aws_subnet" "jtier1" {
  vpc_id            = aws_vpc(var.info_vpc.aws_vpc[1].count.index.id)
  count             = length(var.info_vpc.subnets_names)
  cidr_block        = cidrsubnet(var.info_vpc.cidr_block[1], 8, count.index)
  availability_zone = "${var.region}${var.info_vpc.subnets_zones[count.index]}"
  tags = {
    Name = var.info_vpc.subnets_names[count.index]

  }
  depends_on = [
    aws_vpc.jtier1
  ]
}