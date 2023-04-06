locals {
  vpc_id=var.toyota.id
  gateway_id= aws_internet_gateway.tig.id
  anywhere="0.0.0.0/0"

}