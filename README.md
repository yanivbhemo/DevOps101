# DevOps101
DevOps tutorial for intermidiates

## Stage 0 - Preperations
### Git
1. Please download + install git to your computer<br>
`https://github.com/git-for-windows/git/releases/download/`

2. Open Command Line (CMD) and run:<br>
`cd %USERPROFILE%\Desktop`

3. Now we want to download the workshop's code repoistory to our computer.
Run the following:<br>
`git clone https://github.com/yanivbhemo/DevOps101.git`<br>
`cd DevOps101`

### Entering AWS credentials
1. Each one of you the participants recieved a key to his demo user in aws<br>
Please insert them like this:<br>
<b> Do not do this in a production environment</b>
```
cd %USERPROFILE%
mkdir .aws && cd .aws
vi credentials 
```
2. Write the following inside the new credentials file + <br>
Change the access_key_id & secret with what you received from us and save the file<br>
```
[default]
aws_access_key_id = ********************
aws_secret_access_key = *****************************
```

## Stage 1 - Deploy infrastrcture using Terraform
In this section we will deploy 2 lightsail servers in aws using
IaaS/IaC methodologies.<br>
The tool we will use is <a href="https://learn.hashicorp.com/terraform">Terraform</a>, one of the most popular tools for that kind of requirements made by Hashicorp 

### Terraform installation
1. Please download Terraform to your computer - <br>
`https://www.terraform.io/downloads.html`

2. Unzip the package and save the binary into one of the following  - <br>
`Windows: C:\Windows\System32`<br>
`Linux: /usr/local/bin`

3. Verify the installation by entering CMD/Shell and run:<br>
`terraform`

### Build infrastrcture
1. Inside the repository you will find the following directory `01-terraform-aws-instance`<br>
Please enter to it.<br>
`cd learn-terraform-aws-instance`

2. Initilization phase - First action before run any new configuration<br>
`terraform init`<br><br>
<b>Output:</b>
```
C:\Users\benhay\Desktop\DevOps101\01-terraform-aws-instance>terraform init

Initializing the backend...

Initializing provider plugins...
- Checking for available provider plugins...
- Downloading plugin for provider "aws" (hashicorp/aws) 2.56.0...

The following providers do not have any version constraints in configuration,
so the latest version was installed.

To prevent automatic upgrades to new major versions that may contain breaking
changes, it is recommended to add version = "..." constraints to the
corresponding provider blocks in configuration, with the constraint strings
suggested below.

* provider.aws: version = "~> 2.56"

Terraform has been successfully initialized!

You may now begin working with Terraform. Try running "terraform plan" to see
any changes that are required for your infrastructure. All Terraform commands
should now work.

If you ever set or change modules or backend configuration for Terraform,
rerun this command to reinitialize your working directory. If you forget, other
commands will detect it and remind you to do so if necessary.
```

3. In order to be able to connect to the lightsail servers we will create, or any other vm that you create in AWS<br>
We will use ssh-key. It is not mandatory, but a very important security best practice. Connect without a password.<br>
```
<b>C:\Users\benhay\Desktop\DevOps101\01-terraform-aws-instance>ssh-keygen</b>
Generating public/private rsa key pair.
Enter file in which to save the key (C:\Users\benhay/.ssh/id_rsa): C:\Users\benhay\Desktop\DevOps101\01-terraform-aws-instance\id_rsa
Enter passphrase (empty for no passphrase):
Enter same passphrase again:
Your identification has been saved in C:\Users\benhay\Desktop\DevOps101\01-terraform-aws-instance\id_rsa.
Your public key has been saved in C:\Users\benhay\Desktop\DevOps101\01-terraform-aws-instance\id_rsa.pub.
The key fingerprint is:
SHA256:/yqneHGmpu03J6Fl+UctlUiCC80SG4gYIkScmc2BIFI corp\benhay@W10HWW95Y2
The key's randomart image is:
+---[RSA 2048]----+
|@=E.o .o+ .      |
|=B + . oo+ . .   |
|       .V . o . .|
|         .   . ..|
|        S  .   o |
|        ..A   o .|
|         ... . . |
|       o* =.. .  |
|      o=+=.-..   |
+----[SHA256]-----+
```

4. Prepare the config file - <br>
In the config file we will write all the resources we need to deploy.<br>
I have prepared one in advance for you, lets check it out.<br>
```tf
C:\Users\benhay\Desktop\DevOps101\01-terraform-aws-instance>cat example.tf

provider "aws" {
	profile    = "default"
	region     = "eu-west-1"
}

resource "aws_lightsail_key_pair" "general_key" {
  name   = "general_key"
  public_key = file("id_rsa.pub")
}

resource "aws_lightsail_instance" "dell-devops-lab01" {
  key_pair_name    	= aws_lightsail_key_pair.general_key.name
  name              = "dell-devops-lab01"
  availability_zone = "eu-west-1a"
  blueprint_id      = "amazon_linux_2018_03_0_2"
  bundle_id         = "nano_2_0"
  connection {
		type	=	"ssh"
		user	=	"ec2-user"
		private_key	=	file("id_rsa")
		host        = self.public_ip_address
	}
  
  provisioner "remote-exec" {
    inline = [
	  "sudo yum -y update",
      "sudo amazon-linux-extras enable nginx1.12",
      "sudo yum -y install nginx",
      "sudo service nginx start"
    ]
  }
}

resource "aws_lightsail_instance" "dell-devops-lab02" {
  key_pair_name    	= aws_lightsail_key_pair.general_key.name
  name              = "dell-devops-lab02"
  availability_zone = "eu-west-1a"
  blueprint_id      = "amazon_linux_2018_03_0_2"
  bundle_id         = "nano_2_0"
  connection {
		type	=	"ssh"
		user	=	"ec2-user"
		private_key	=	file("id_rsa")
		host        = self.public_ip_address
	}
  
  provisioner "remote-exec" {
    inline = [
	  "sudo yum -y update",
      "sudo amazon-linux-extras enable nginx1.12",
      "sudo yum -y install nginx",
      "sudo service nginx start"
    ]
  }
}
```

5. After all the resources have been written, we run `terraform validate` and check our config<br>
```tf
C:\Users\benhay\Desktop\DevOps101\01-terraform-aws-instance>terraform validate
Success! The configuration is valid.
```

6. If the config has been validated, we can apply it using `terraform apply`<br>
Terraform will present us what it is about to create and asks us if we agree or not<br>
```tf
C:\Users\benhay\Desktop\DevOps101\01-terraform-aws-instance>terraform apply

An execution plan has been generated and is shown below.
Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # aws_lightsail_instance.dell-devops-lab01 will be created
  + resource "aws_lightsail_instance" "dell-devops-lab01" {
      + arn                = (known after apply)
      + availability_zone  = "eu-west-1a"
      + blueprint_id       = "amazon_linux_2018_03_0_2"
      + bundle_id          = "nano_2_0"
      + cpu_count          = (known after apply)
      + created_at         = (known after apply)
      + id                 = (known after apply)
      + ipv6_address       = (known after apply)
      + is_static_ip       = (known after apply)
      + key_pair_name      = "general_key"
      + name               = "dell-devops-lab01"
      + private_ip_address = (known after apply)
      + public_ip_address  = (known after apply)
      + ram_size           = (known after apply)
      + username           = (known after apply)
    }

  # aws_lightsail_instance.dell-devops-lab02 will be created
  + resource "aws_lightsail_instance" "dell-devops-lab02" {
      + arn                = (known after apply)
      + availability_zone  = "eu-west-1a"
      + blueprint_id       = "amazon_linux_2018_03_0_2"
      + bundle_id          = "nano_2_0"
      + cpu_count          = (known after apply)
      + created_at         = (known after apply)
      + id                 = (known after apply)
      + ipv6_address       = (known after apply)
      + is_static_ip       = (known after apply)
      + key_pair_name      = "general_key"
      + name               = "dell-devops-lab02"
      + private_ip_address = (known after apply)
      + public_ip_address  = (known after apply)
      + ram_size           = (known after apply)
      + username           = (known after apply)
    }

  # aws_lightsail_key_pair.general_key will be created
  + resource "aws_lightsail_key_pair" "general_key" {
      + arn                   = (known after apply)
      + encrypted_fingerprint = (known after apply)
      + encrypted_private_key = (known after apply)
      + fingerprint           = (known after apply)
      + id                    = (known after apply)
      + name                  = "general_key"
      + private_key           = (known after apply)
      + public_key            = <<~EOT
            ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDgh1U3nIHvqV4r/l2EVQSlPw+OzH2zOMChlf6eHjUZoo3IpwLhE5jQZBzLI/4TNllY2ZgWt8maq/0y/DJVKhkQj+zK0ETp7jNqYv4INM3y7okGsdNxgsrbUOw8i6hShY1DKfk7GeNAy8lUljjijhdMDWQHT2Nz5ekRxT1EDjXfSN0lIQDRYOhIrRHB7DrXXXXXXXXXXXXXXXXXXXX6gc56+woykskP28bPbVdk029c3N/xqoISzfprVRD7S+gZ5lkcLpPKaq3REWH45akPmXj3y4PVHoIbZ5TjLYR1+aj/gfsB9SsfmEQp4PUpLOpSwdslmpQlRoGOdWqT4RkpK/QxPv1d benhay@W10HWW95Y2
        EOT
    }

Plan: 3 to add, 0 to change, 0 to destroy.

Enter a value: yes
```
```  
aws_lightsail_instance.dell-devops-lab02: Creating...
aws_lightsail_instance.dell-devops-lab01: Creating...
aws_lightsail_instance.dell-devops-lab02: Still creating... [10s elapsed]
aws_lightsail_instance.dell-devops-lab01: Still creating... [10s elapsed]
aws_lightsail_instance.dell-devops-lab02: Still creating... [20s elapsed]
aws_lightsail_instance.dell-devops-lab01: Still creating... [20s elapsed]
aws_lightsail_instance.dell-devops-lab01: Creation complete after 29s [id=dell-devops-lab01]
aws_lightsail_instance.dell-devops-lab02: Still creating... [30s elapsed]
aws_lightsail_instance.dell-devops-lab02: Still creating... [40s elapsed]
aws_lightsail_instance.dell-devops-lab02: Still creating... [50s elapsed]
aws_lightsail_instance.dell-devops-lab02: Still creating... [1m0s elapsed]
aws_lightsail_instance.dell-devops-lab02: Still creating... [1m10s elapsed]
aws_lightsail_instance.dell-devops-lab02: Creation complete after 1m12s [id=dell-devops-lab02]

Apply complete! Resources: 3 added, 0 changed, 0 destroyed.
```

7. After several minutes we would be able to see the new lightsail server we deployed at both the AWS console<br>
and thourgh terraform cli<br>
```tf
C:\Users\benhay\Desktop\DevOps101\01-terraform-aws-instance>terraform show

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
    <b>public_ip_address  = "X.X.X.X"</b>
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
    <b>public_ip_address  = "X.X.X.X"</b>
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

8. Let's check if both our servers are alive and configures as we wanted:<br>
Open another tab in the explorer you use and enter the following url - <br>
`http://<1st server public ip>/`<br>
`http://<2nd server public ip>/`<br>
In both you should see the "NGINX" first page

## Quick recap
![](https://i.imgur.com/OAmoez9.png)
------------

<b>Next: [Containers](https://github.com/yanivbhemo/DevOps101/blob/master/02-Containers.md)</b>
