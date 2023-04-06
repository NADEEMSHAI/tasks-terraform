resource "aws_vpc" "main" {
  cidr_block = var.info_vpc.cidr_vpc
  tags = {
    Name = "Practice1"
  }
}
resource "aws_subnet" "nadeem" {
  count             = length(var.info_vpc.subnets_names)
  cidr_block        = cidrsubnet(var.info_vpc.cidr_vpc, 8, count.index)
  vpc_id            = aws_vpc.main.id
  availability_zone = "${var.region}${var.info_vpc.subnets_zones[count.index]}"
  tags = {
    Name = var.info_vpc.subnets_names[count.index]
  }
  depends_on = [
    aws_vpc.main
  ]
}

