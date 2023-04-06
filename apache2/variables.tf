variable "region" {
  type    = string
  default = "ap-south-1"

}
variable "vpc_info" {
  type = object({
    cidr_vpc        = string
    subnets_names   = list(string)
    subnets_zones   = list(string)
    public_subnets  = list(string)
    private_subnets = list(string)
    web_ec2_subnet  = string
    subnet_cidrs    = list(string)


  })
  default = {
    cidr_vpc        = "10.100.0.0/16"
    subnets_names   = ["app1", "app2", "db1", "db2"]
    subnets_zones   = ["a", "b", "a", "b"]
    public_subnets  = ["web1", "web2"]
    private_subnets = ["app1", "app2", "db1", "db2"]
    db_subnets      = ["db1", "db2"]
    web_ec2_subnet  = "web1"
    subnet_cidrs    = [""]


  }
}
