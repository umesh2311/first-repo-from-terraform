# Creating ssh key
resource "aws_key_pair" "terraform-key-pair" {
  key_name   = var.key_name //key will be generated by this name in AWS
  public_key = var.key      //content of the public key
}

#creating instance
resource "aws_instance" "terraform_ec2_instance" {
  ami           = var.image_id
  instance_type = local.instance_type
  key_name = aws_key_pair.terraform-key-pair.key_name

}

output "publicIp" {
  value = aws_instance.terraform_ec2_instance.public_ip
}

//If we use locals inside the module, it will always use the value of instance_type as defined inside
//locals block. it won't be overridden from the root module or other module calling it.
locals {
  instance_type = "t2.large"
}