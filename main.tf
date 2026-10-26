provider "aws" {
  region = var.region
}

provider "random" {}

# data "aws_ami" removido — bloqueado pela SCP

resource "random_pet" "instance" {
  length = 2
}

module "ec2-instance" {
  source = "./modules/aws-ec2-instance"

  ami_id        = "ami-0fc53b217ec1ad816"  # Ubuntu Noble 24.04 amd64 - us-east-2
  instance_name = random_pet.instance.id
}

module "hello" {
  source  = "joatmon08/hello/random"
  version = "6.0.0"

  hellos = {
    hello        = random_pet.instance.id
    second_hello = "World"
  }

  some_key = var.secret_key
}
