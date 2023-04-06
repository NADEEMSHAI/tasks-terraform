region = "ap-south-1"
vpc_info = {
  cidr_vpc        = "10.100.0.0/16"
  private_subnets = ["app1", "app2", "db1", "db2"]
  public_subnets  = ["web1", "web2"]
  subnet_cidrs    = ["10.100.0.0/24", "10.100.1.0/24", "10.100.2.0/24", "10.100.3.0/24", "10.100.4.0/24", "10.100.5.0/24"]
  subnets_names   = ["web1", "web2", "app1", "app2", "db1", "db2"]
  subnets_zones   = ["a", "b", "a", "b", "a", "b"]
  web_ec2_subnet  = "web1"
}