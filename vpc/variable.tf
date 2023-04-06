variable "region" {
  type    = string
  default = "ap-south-1"
}

variable "info_vpc" {
  type = object({
    subnets_names = list(string)
    subnets_zones = list(string)
    cidr_vpc      = string
  })
  default = {
    cidr_vpc      = "192.168.0.0/16"
    subnets_names = ["fortuner", "scorpio", "fortuner", "scorpio"]
    subnets_zones = ["a", "a", "a", "a"]
  }
}