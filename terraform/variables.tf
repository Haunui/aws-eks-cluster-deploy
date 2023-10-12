locals {
  prefix = "lefootcestrince"
  region = "eu-west-1"

  subnets = {
    subnet1 = {
      cidr_block = "10.0.1.0/24"
      availability_zone = "eu-west-1a"
      map_public_ip_on_launch = true
    }

    subnet2 = {
      cidr_block = "10.0.2.0/24"
      availability_zone = "eu-west-1b"
      map_public_ip_on_launch = true
    }
  }

  security_groups = {
    useraccess = {
      ingress = {
        ssh = {
          from_port = 22
          to_port = 22
          protocol = "tcp"
          cidr_blocks = ["0.0.0.0/0"]
        }

        http = {
          from_port = 80
          to_port = 80
          protocol = "tcp"
          cidr_blocks = ["0.0.0.0/0"]
        }
      }

      egress = {
        all = {
          from_port = 0
          to_port = 0
          protocol = "-1"
          cidr_blocks = ["0.0.0.0/0"]
        }
      }
    }
    cluster = {
      ingress = {
        all = {
          from_port = 0
          to_port = 0
          protocol = "-1"
          cidr_blocks = ["0.0.0.0/0"]
        }
        nodeport = {
          from_port = 30080
          to_port = 30080
          protocol = "TCP"
          cidr_blocks = ["0.0.0.0/0"]
        }
      }
      egress = {
        all = {
          from_port = 0
          to_port = 0
          protocol = "-1"
          cidr_blocks = ["0.0.0.0/0"]
        }
      }
    }
  }

  iam_role = "EKS_Students"

  eks_cluster = {
    version = "1.27"
    addons = ["coredns","kube-proxy","vpc-cni"]

    scaling_config = {
      desired_size = 2
      max_size = 5
      min_size = 1
    }

  }
}
