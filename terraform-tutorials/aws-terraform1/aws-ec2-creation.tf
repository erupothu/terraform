provider "aws" {
    region = "ap-south-1"
    access_key = "AKIAW3GAUAPNG7JUBR4E"
    secret_key = "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"
}

variable "ingressrules" {
  type    = list(number)
  default = [8080, 22]
}

variable "awsprops" {
    default = {
    region = "ap-south-1"
    vpc = "vaya-vpc"
    ami = "ami-ubuntu"
    itype = "t2.micro"
    subnet = "subnet-vaya"
    publicip = true
    keyname = "myseckey"
    secgroupname = "IAC-Sec-Group"
  }
}

resource "aws_vpc" "vpc1" {
  cidr_block = "172.16.0.0/16"

  tags = {
      Name = lookup(awsprops, "vpc")
  }
}

resource "aws_subnet" "vaya_subnet" {
  vpc_id = aws_vpc.vpc1.id
  cidr_block = "172.16.10.0/24"
  availability_zone = "ap-south-1"

  tags = {
    "Name" = lookup(awsprops, "subnet")
  }
}

resource "aws_network_interface" "inetwork" {
  subnet_id = aws_subnet.vaya_subnet.id
  private_ips = ["172.16.10.100"]

  tags = {
    "Name" = "vaya-network-interface"
  }
}

resource "aws_security_group" "project-iac-sg" {
  name = "Allow web traffic"
  description = "inbound ports for ssh and standard http and everything outbound"

dynamic "ingress" {
    iterator = port
    for_each = var.ingressrules
    content {
      from_port   = port.value
      to_port     = port.value
      protocol    = "TCP"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
  // To Allow SSH Transport
  ingress {
    from_port = 22
    protocol = "tcp"
    to_port = 22
    cidr_blocks = ["0.0.0.0/0"]
  }

  // To Allow Port 80 Transport
  ingress {
    from_port = 80
    protocol = ""
    to_port = 80
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }

  lifecycle {
    create_before_destroy = true
  }
}

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

resource "aws_instance" "jenikins_server" {
  ami = data.aws_ami.ubuntu.id
  instance_type = lookup(awsprops,"itype")
  associate_public_ip_address = lookup(awsprops, "publicip")

  network_interface {
    network_interface_id = aws_network_interface.inetwork.id
    device_index = 0
  }

  vpc_security_group_ids = [aws_security_group.project-iac-sg]

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

# resource "aws_ebs_volume" "jenkins_volume" {
#   availability_zone = aws_props.region
#   size = 40
# }

# resource "aws_volume_attachment" "ebs_att" {
#   device_name = "/dev/sdh"
#   volume_id = aws_ebs_volume.jenkins_volume.id
#   instance_id = aws_instance.jenikins_server.id
# }



