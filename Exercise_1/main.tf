# TODO: Designate a cloud provider, region, and credentials
provider "aws" {
  profile    = "default"
  region     = "us-east-1"
  access_key = ""
  secret_key = ""
}

# TODO: provision 4 AWS t2.micro EC2 instances named Udacity T2
resource "aws_instance" "Udacity-T2" {
  count         = 4
  ami           = "ami-0742b4e673072066f"
  instance_type = "t2.micro"
  tags = {
    name = "Udacity T2"
  }
}

# TODO: provision 2 m4.large EC2 instances named Udacity M4
resource "aws_instance" "Udacity-M4" {
  count         = 2
  ami           = "ami-0742b4e673072066f"
  instance_type = "m4.large"
  
  tags = {
    name = "Udacity M4"
  }
}