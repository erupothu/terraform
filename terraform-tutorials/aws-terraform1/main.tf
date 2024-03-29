provider "aws" {
	region = "ap-south-1"
    access_key = "AKIAW3GAUAPNG7JUBR4E"
    secret_key = "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"
}

# Create VPC
resource "aws_vpc" "dev-vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "development"
  }
}

# Create subnet(s)
# Subnets have to be allowed to automatically map public IP addresses for worker nodes
resource "aws_subnet" "dev1-subnet" {
  vpc_id     = aws_vpc.dev-vpc.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "ap-south-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "dev1-subnet"
  }
}

resource "aws_subnet" "dev2-subnet" {
  vpc_id     = aws_vpc.dev-vpc.id
  cidr_block = "10.0.2.0/24"
  availability_zone = "ap-south-1"
  map_public_ip_on_launch = true

  tags = {
    Name = "dev2-subnet"
  }
}

# Create Internet Gateway
resource "aws_internet_gateway" "dev-gw" {
  vpc_id = aws_vpc.dev-vpc.id

  tags = {
    Name = "dev-gw"
  }
}

# Create Route Table
resource "aws_route_table" "dev-route-table" {
  vpc_id = aws_vpc.dev-vpc.id

  route {
      cidr_block = "0.0.0.0/0"
      gateway_id = aws_internet_gateway.dev-gw.id
    }

  route {
      ipv6_cidr_block        = "::/0"
      gateway_id = aws_internet_gateway.dev-gw.id
    }
  

  tags = {
    Name = "dev-rt"
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
  name        = "allow_tls"
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
  private_ips     = ["10.0.1.50"]
  security_groups = [aws_security_group.allow-web-traffic.id]
}

# Create Elastic IP
resource "aws_eip" "one" {
  vpc                       = true
  network_interface         = aws_network_interface.dev-server-nic.id
  associate_with_private_ip = "10.0.1.50"
  depends_on = [aws_internet_gateway.dev-gw]
}

# Commented out unless needed. Not needed for EKS cluster deployment
# Create Server
data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name = aws_props.ami
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name = "visualization_type"
    values = ["hvm"]
  }
}

resource "aws_instance" "dev-server" {
	ami = data.aws_ami.ubuntu
	instance_type = "t2.micro"
	availability_zone = "ap-south-1"
	key_name = "terraform-main-key"
	user_data = <<-EOF
		    #!/bin/bash
		    sudo yum update -y
		    sudo yum install httpd -y
		    sudo systemctl start httpd
		    sudo bash -c 'echo this is a test > /var/www/html/index.html'
		    EOF

	network_interface {
	  device_index = 0
	  network_interface_id = aws_network_interface.dev-server-nic.id
    }
	root_block_device {
    delete_on_termination = true
    iops = 150
    volume_size = 50
    volume_type = "gp2"
  }

  tags = {
    Name ="SERVER01"
    Environment = "DEV"
    OS = "UBUNTU"
    Managed = "IAC"
  }
}