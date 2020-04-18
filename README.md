# Jenkins00
This is for a project that will run in Jenkins. There are a few things you need but the general skeleton will work. Some of the things you will need include:
- aws-access-key-id (from an AWS iam user role)
- aws-secret-access-key (from an AWS iam user role)
- security group called `BasicTesting` which will have the necessary ports open
- an ssh key called `awstestpem.pem` that exists both in AWS and locally. This ssh key should exist in the normal location, ~/.ssh/awstestpem.pem


## There are two files:
#### terraform file, aws00.tf
- this script will provision and bring up an ec2 machine 
- after the machine is up and running, it will take the machine's IP address and identifier and output it to a file 


#### Ansible file, configure.yml
- this script will take the output from previous file as it's host 
- install things necessary to install docker (python, pip, etc) 
- pull a docker image (hello-world) 
- create a docker container using the image inside the previous ec2 machine and reboot 


#### Assuming we have an existing Jenkins server, one can create a new job with the following shell commands:
- export AWS_ACCESS_KEY_ID= `insert-key-id`
- export AWS_SECRET_ACCESS_KEY= `insert-secret-access-key`
- this command changes depending on the user's system: cd /home/pk/Documents/Projects/Jenkins00
- sudo --preserve-env terraform apply -auto-approve -lock=false
- sudo ansible-playbook configure.yml -i machinehost --key-file "../../../.ssh/awstestpem.pem"

---
We end up with an EC2 machine with a docker container using the `hello-world` image.
All brought up and configured automatically using a Jenkins job.

