variable "region" {
  type    = string
  default = "ap-south-1"
}

variable "info_vpc" {
  type = object({
    cidr_block    = list(string)
    subnets_names = list(string)
    subnets_zones = list(string)
    aws_vpc       = list(string)
  })
  default = {
    cidr_block    = ["10.100.0.0/16", "192.168.0.0/16"]
    subnets_names = ["app1", "app2", "app3", "web1", "web2", "web3", ]
    subnets_zones = ["a", "b", "c", "a", "b", "c"]
    aws_vpc       = ["ntier1", "jtier1"]
  }
}