# Containers
## What is it?
Package Software into virtual Units for Development, Shipment and Deployment<br>A container is a standard unit of software that packages up code and all its dependencies so the application runs quickly and reliably from one computing environment to another. A Docker container image is a lightweight, standalone, executable package of software that includes everything needed to run an application: code, runtime, system tools, system libraries and settings.

Its true that we have VMware VRA blueprints and templates or pre-configured images, but<br>The reality today is that requirements became much more complex than before,<br>and even if they aren't at you organization - it still consume a lot of time and resources from the IT/System department to deploy servers.<br>
We want to go faster. We want to write what we need and get it.

## Lets play with it
1. Let's first connect to our first server that we have deployed earlier
We will do it like this:
```
C:\Users\benhay\OneDrive - Dell Technologies\Documents\Proconsult-Israel\DevOps101\01-terraform-aws-instance><b>terraform show</b>
# aws_lightsail_instance.dell-devops-lab01:
resource "aws_lightsail_instance" "dell-devops-lab01" {
    arn                = "arn:aws:lightsail:eu-west-1:324324095483:Instance/049fe37b-b2e6-4bbb-845a-b9a86c817dda"
    availability_zone  = "eu-west-1a"
    blueprint_id       = "amazon_linux_2018_03_0_2"
    bundle_id          = "nano_2_0"
    cpu_count          = 1
    created_at         = "2020-04-16T07:42:09Z"
    id                 = "dell-devops-lab01"
    is_static_ip       = false
    key_pair_name      = "general_key"
    name               = "dell-devops-lab01"
    private_ip_address = "172.26.14.189"
    public_ip_address  = "63.35.175.91"
    username           = "ec2-user"
}

# aws_lightsail_instance.dell-devops-lab02:
resource "aws_lightsail_instance" "dell-devops-lab02" {
    arn                = "arn:aws:lightsail:eu-west-1:324324095483:Instance/388e01bf-8ae8-4ff7-80ac-b630dd520396"
    availability_zone  = "eu-west-1a"
    blueprint_id       = "amazon_linux_2018_03_0_2"
    bundle_id          = "nano_2_0"
    cpu_count          = 1
    created_at         = "2020-04-16T07:42:09Z"
    id                 = "dell-devops-lab02"
    is_static_ip       = false
    key_pair_name      = "general_key"
    name               = "dell-devops-lab02"
    private_ip_address = "172.26.7.67"
    public_ip_address  = "54.228.183.121"
    username           = "ec2-user"
}

# aws_lightsail_key_pair.general_key:
resource "aws_lightsail_key_pair" "general_key" {
    arn         = "arn:aws:lightsail:eu-west-1:324324095483:KeyPair/f98d6a52-ea37-4ea7-8365-e961f1d70148"
    fingerprint = "60:84:f2:85:63:4d:b6:13:d1:00:72:43:90:b5:e6:ec"
    id          = "general_key"
    name        = "general_key"
    public_key  = <<~EOT
        ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDgh1U3nIHvqV4r/l2EVQSlPw+OzH2zOMChlf6eHjUZoo3IpwLhE5jQZBzLI/4TNllY2ZgWt8maq/0y/DJVKhkQj+zK0ETp7jNqYv4INM3y7okGsdNxgsrbUOw8i6hShY1DKfk7GeNAy8lUljjijhdMDWQHT2Nz5ekRxT1EDjXfSN0lIQDRYOhIrRHB7DrTi0cMg4CMEeMdzXM6gc56+woykskP28bPbVdk029c3N/xqoISzfprVRD7S+gZ5lkcLpPKaq3REWH45akPmXj3y4PVHoIbZ5TjLYR1+aj/gfsB9SsfmEQp4PUpLOpSwdslmpQlRoGOdWqT4RkpK/QxPv1d benhay@W10HWW95Y2
    EOT
}
```