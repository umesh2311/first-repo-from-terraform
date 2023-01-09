/*
module "mywebserver" {
  source        = "./modules/webserver"
  image_id      = var.image_id
  instance_type = "m2.large"    //defining it here won't override it inside the module if we have use locals instead of var there.
  secret_key    = var.secret_key
  access_key    = var.access_key
  key           = file("${path.module}/id_rsa.pub")
  key_name      = var.key_name
}
output "publicIpOfInstanceIs" {
  value = module.mywebserver.publicIp
}
*/
module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 3.0"

  name = "single-instance"

  ami                    = var.image_id
  instance_type          = var.instance_type
  key_name               = "terraform_key_pair"
  monitoring             = true
  vpc_security_group_ids = ["sg-0e180c35f0ca0cb97"]

  tags = {
    Terraform   = "true"
    Environment = "dev"
    Name = "ec2-instance-through-module"
  }
}