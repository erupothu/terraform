# module "vpc" {
#   source = "terraform-aws-modules/vpc/aws"

#   name = "my-vpc"
#   cidr = "10.0.0.0/16"

#   azs             = ["eu-west-1a", "eu-west-1b", "eu-west-1c"]
#   private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
#   public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]

#   enable_nat_gateway = true
#   enable_vpn_gateway = true

#   tags = {
#     Terraform = "true"
#     Environment = "dev"
#   }
# }

# Create VPC
resource "aws_vpc" "dev-vpc" {
  cidr_block = var.vpc_cidr_block
  tags = {
    Name = var.vpc_tag_name
  }
}

# Create subnet(s)
# Subnets have to be allowed to automatically map public IP addresses for worker nodes
resource "aws_subnet" "dev1-subnet" {
  vpc_id     = aws_vpc.dev-vpc.id
  cidr_block =var.subnet_cidr_block
  availability_zone = var.subnet_azs_a
  map_public_ip_on_launch = true

  tags = {
    Name = var.subnet1_tag_name
  }
}

resource "aws_subnet" "dev2-subnet" {
  vpc_id     = aws_vpc.dev-vpc.id
  cidr_block =var.subnet_cidr_block
  availability_zone = var.subnet_azs_b
  map_public_ip_on_launch = true

  tags = {
    Name = var.subnet2_tag_name
  }
}

# Create Internet Gateway
resource "aws_internet_gateway" "dev-gw" {
  vpc_id = aws_vpc.dev-vpc.id

  tags = {
    Name = var.igw_tag_name
  }
}

# Create Route Table
resource "aws_route_table" "dev-route-table" {
  vpc_id = aws_vpc.dev-vpc.id

  route {
      cidr_block = var.route_cidr_block
      gateway_id = aws_internet_gateway.dev-gw.id
    }

  route {
      ipv6_cidr_block = var.route_apv6_cidr_block
      gateway_id = aws_internet_gateway.dev-gw.id
    }

  tags = {
    Name = var.route_tag_name
  }
}

# Create Route Table Association for dev1-subnet to dev-rt
resource "aws_route_table_association" "dev1-sub-to-dev-rt" {
  subnet_id      = aws_subnet.dev1-subnet.id
  route_table_id = aws_route_table.dev-route-table.id
}

# Create Route Table Association for dev1-subnet to dev-rt
resource "aws_route_table_association" "dev2-sub-to-dev-rt" {
  subnet_id      = aws_subnet.dev2-subnet.id
  route_table_id = aws_route_table.dev-route-table.id
}

# Create a security group for HTTPS, HTTP, and SSH
resource "aws_security_group" "allow-web-traffic" {
  name        = var.security_group_tag_name
  description = "Allow web traffic"
  vpc_id      = aws_vpc.dev-vpc.id

  ingress {
      description      = "HTTPS"
      from_port        = 443
      to_port          = 443
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
    }

  ingress {
      description      = "HTTP"
      from_port        = 80
      to_port          = 80
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
    }

  ingress {
      description      = "SSH"
      from_port        = 22
      to_port          = 22
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
    }

  egress {
      from_port        = 0
      to_port          = 0
      protocol         = "-1"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
    }

  tags = {
    Name = "allow-web"
  }
}

# Create a NIC(s)
resource "aws_network_interface" "dev-server-nic" {
  subnet_id       = aws_subnet.dev1-subnet.id
  private_ips     = var.nic_private_ip
  security_groups = [aws_security_group.allow-web-traffic.id]
}

# Create Elastic IP
# resource "aws_eip" "one" {
#   vpc                       = true
#   network_interface         = aws_network_interface.dev-server-nic.id
#   associate_with_private_ip = var.eip
#   depends_on = [aws_internet_gateway.dev-gw]
# }