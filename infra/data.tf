
data "aws_availability_zones" "available" {
  state = "available"
}

# data "external" "myipaddr" {
#   program = ["bash", "-c", "curl -s 'https://api.ipify.org?format=json'"]
# }

# data "aws_ami" "ubuntu" {
#   most_recent = true

#   filter {
#     name   = "name"
#     values = ["ubuntu/images/hvm-ssd/ubuntu-xenial-16.04-amd64-server-*"]
#   }

#   filter {
#     name   = "virtualization-type"
#     values = ["hvm"]
#   }

#   owners = ["099720109477"] # Canonical
# }
