module "securitygroup" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "3.0.1"
  
  name = "ec2-web-sgp"
  vpc_id = module.vpc.vpc_id

  computed_ingress_with_cidr_blocks = [ 
    {
      from_port   = 80
      to_port     = 80
      protocol    = 6
      description = "Web HTTP"
      cidr_blocks = "0.0.0.0/0"
    },
    {
      from_port   = 443
      to_port     = 443
      protocol    = 6
      description = "Web HTTPS"
      cidr_blocks = "0.0.0.0/0"
    },
  ]

  number_of_computed_ingress_with_cidr_blocks = 2

  computed_egress_with_cidr_blocks = [
    {
        from_port = 0
        to_port = 0
        protocol = -1
        description = "All Out Bound Allowed"
        cidr_blocks = "0.0.0.0/0"
    }
  ]
  number_of_computed_egress_with_cidr_blocks = 1    
}
