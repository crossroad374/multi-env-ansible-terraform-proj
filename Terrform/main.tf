#dev

module "dev-infra" {
  source="./infra"
  env="dev"
  instance_count = 1
  instance_type = "t2.micro"
  ami = "ami-03fd334507439f4d1"
  volume_size = 10 
}

/*
#stg

module "stg-infra" {
    source = "./infra"
    env = "stg"
    instance_count = 2
    instance_type = "t2.small"
    ami = "ami-03fd334507439f4d1"
    volume_size = 10
}
#prd

module "prd-infra" {
    source = "./infra"
    env = "prd"
    instance_count = 3
    instance_type = "t2.micro"
    ami = "ami-03fd334507439f4d1"
    volume_size = 10
}
*/

output "dev_infra_ec2_public_ips" {
  value = module.dev-infra.ec2_public_ips
}
/*

output "stg_infra_ec2_public_ips" {
  value = module.stg-infra.ec2_public_ips
}


output "prd_infra_ec2_public_ips" {
  value = module.prd-infra.ec2_public_ips
}
*/
