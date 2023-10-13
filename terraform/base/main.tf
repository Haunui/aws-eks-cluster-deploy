variable "prefix" {}
variable "region" {}
variable "subnets" {}
variable "security_groups" {}

terraform {
	required_providers {
		aws = {
			source = "hashicorp/aws"
			version = "~> 5.0"
		}
	}
}

provider "aws" {
	region = var.region
}


resource "aws_vpc" "vpc" {
	cidr_block = "10.0.0.0/16"

	tags = {
		Name = "${var.prefix}-vpc"
    LeJ = "cestleS"
	}
}

resource "aws_subnet" "subnet" {
  for_each = var.subnets

	vpc_id = aws_vpc.vpc.id
	cidr_block = each.value.cidr_block
  availability_zone = each.value.availability_zone
  map_public_ip_on_launch = each.value.map_public_ip_on_launch

	tags = {
		Name = "${var.prefix}-subnet-${each.key}"
    LeJ = "cestleS"
	}
}

resource "aws_network_interface" "nic" {
  for_each = var.subnets

	subnet_id = aws_subnet.subnet["${each.key}"].id

  tags = {
    Name = "${var.prefix}-nic-${each.key}"
    LeJ = "cestleS"
  }
}

resource "aws_internet_gateway" "igw" {
	vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "${var.prefix}-igw"
    LeJ = "cestleS"
  }
}

resource "aws_route_table" "rtb" {
	vpc_id = aws_vpc.vpc.id

	route {
		cidr_block = "0.0.0.0/0"
		gateway_id = aws_internet_gateway.igw.id
	}

  tags = {
    Name = "${var.prefix}-rtb"
    LeJ = "cestleS"
  }
}

resource "aws_route_table_association" "rtba" {
  for_each = var.subnets

	subnet_id = aws_subnet.subnet["${each.key}"].id
	route_table_id = aws_route_table.rtb.id
}

resource "aws_security_group" "sg" {
  for_each = toset(var.security_groups)

	vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "${var.prefix}-sg-${each.key}"
    LeJ = "cestleS"
  }
}

###### SGR USERACCESS

resource "aws_security_group_rule" "sgr-ingress-useraccess-ssh" {
  type = "ingress"
  from_port = 22
  to_port = 22
  protocol = "tcp"
  cidr_blocks = ["0.0.0.0/0"]

  security_group_id = aws_security_group.sg["useraccess"].id
}

resource "aws_security_group_rule" "sgr-ingress-useraccess-http" {
  type = "ingress"
  from_port = 80
  to_port = 80
  protocol = "tcp"
  cidr_blocks = ["0.0.0.0/0"]

  security_group_id = aws_security_group.sg["useraccess"].id
}

resource "aws_security_group_rule" "sgr-egress-useraccess-all" {
  type = "egress"
  from_port = 0
  to_port = 0
  protocol = "-1"
  cidr_blocks = ["0.0.0.0/0"]

  security_group_id = aws_security_group.sg["useraccess"].id
}


###### SGR CLUSTER

resource "aws_security_group_rule" "sgr-ingress-cluster-http" {
  type = "ingress"
  from_port = 80
  to_port = 80
  protocol = "tcp"
  cidr_blocks = ["0.0.0.0/0"]

  security_group_id = aws_security_group.sg["cluster"].id
}

resource "aws_security_group_rule" "sgr-ingress-cluster-nodeport" {
  type = "ingress"
  from_port = 30080
  to_port = 30080
  protocol = "tcp"
  cidr_blocks = ["0.0.0.0/0"]

  security_group_id = aws_security_group.sg["cluster"].id
}

resource "aws_security_group_rule" "sgr-egress-cluster-all" {
  type = "egress"
  from_port = 0
  to_port = 0
  protocol = "-1"
  cidr_blocks = ["0.0.0.0/0"]

  security_group_id = aws_security_group.sg["cluster"].id
}



output "vpc_id" {
  value = aws_vpc.vpc.id
}

output "subnet_ids" {
  value = {for k,v in aws_subnet.subnet : k => v.id}
}

output "security_group_ids" {
  value = {for k,v in aws_security_group.sg : k => v.id}
}
