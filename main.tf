
module "ec2-keypair" {
  source = "./module/key-pair"
  key_name = "samplekeyname"
  public_key = file("./module/secrets/cloudgeeks.pub")
}

module "iam-instance-profile" {
  source = "./module/ec2_instance_profile"
  ec2_role_name = "sampleec2rolename"
}

module "ec2" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "3.4.0"
    
  name = "cloudgeeks-ec2-two"
  key_name = module.ec2-keypair.key_pair_name

  ami = "ami-04f167a56786e4b09"
  instance_type = "t2.micro"

  associate_public_ip_address = true

  subnet_id = module.vpc.public_subnets[1]
  vpc_security_group_ids = [module.securitygroup.this_security_group_id]
  iam_instance_profile = module.iam-instance-profile.ec2_instance_profile_name

  disable_api_termination = true

  root_block_device = [
    {
      encrypted   = true
      volume_type = "gp3"
      throughput  = 200
      volume_size = 30
    }
  ]

  user_data_base64 = base64encode(<<-EOF
IyEvYmluL2Jhc2gKCmFwdCB1cGRhdGUgLXkgJiYgYXB0IGluc3RhbGwgLXkgYW5zaWJsZSBqcSB0ZWxuZXQKCiMgUHl0aG9uIGluc3RhbGxhdGlvbgphcHQgdXBkYXRlIC15CmFwdCBpbnN0YWxsIHNvZnR3YXJlLXByb3BlcnRpZXMtY29tbW9uIC15CmFkZC1hcHQtcmVwb3NpdG9yeSBwcGE6ZGVhZHNuYWtlcy9wcGEgLXkKYXB0IHVwZGF0ZSAteQphcHQgaW5zdGFsbCAteSBweXRob24KYXB0IGluc3RhbGwgcHl0aG9uMy45IC15CnB5dGhvbiAtLXZlcnNpb24KCgojIEVuZA==
EOF
  )
}