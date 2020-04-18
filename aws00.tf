provider "aws" {
  region = "us-west-2"
#below is not needed since we set environment variables
#  access_key = "TF_VAR_AWS_KEY_ID"
#  secret_key = "TF_VAR_AWS_SECRET_ACCESS_KEY"

}


resource "aws_instance" "TestMachine" {
  ami                          = "ami-003634241a8fcdec0"
  instance_type                = "t2.micro"
  associate_public_ip_address  = "true"
  security_groups              = ["BasicTesting"]
  key_name                     = "awstestpem"
}


resource "local_file" "machineInfo" {
  content = <<EOF
[testing]
${aws_instance.TestMachine.id} ansible_host=${aws_instance.TestMachine.public_ip}

[testing:vars]
ansible_user = ubuntu
ansible_ssh_common_args='-o StrictHostKeyChecking=no'


EOF

  filename = "machinehost"
}
