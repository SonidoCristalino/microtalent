# main.tf

# Public IP: restrict SSH access in the security group.
data "http" "my_ip" {
  url = "http://ipv4.icanhazip.com"
}
