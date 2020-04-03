provider "aws" {
	profile    = "default"
	region     = "eu-west-1"
}

resource "aws_lightsail_instance" "dell-devops-lab01" {
  name              = "custom_gitlab"
  availability_zone = "eu-west-1a"
  blueprint_id      = "amazon_linux_2018_03_0_2"
  bundle_id         = "nano_2_0"
  tags = {
    foo = "bar"
  }
}