locals {
  prefix = "iunuah-eks"
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

  security_groups = ["useraccess", "cluster"]

  iam_role = "EKS_Students"

  eks_cluster = {
    version = "1.27"
    addons = ["kube-proxy","vpc-cni"]

    scaling_config = {
      desired_size = 2
      max_size = 5
      min_size = 1
    }

  }
}
