variable "region" {
  type    = string
  default = "ap-south-1"

}

variable "toyota" {
  type = object({
    subnets_names      = list(string)
    availability_zones = list(string)
    cidr_block=string
  })
  default = {
    subnets_zones = ["a", "b", "a", "b"]
    subnets_names      = ["app1", "app2", "web1", "web2"]
    cidr_block         = "10.100.0.0/16"
  }
}