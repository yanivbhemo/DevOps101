# DevOps101
DevOps tutorial for beginners

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
vi credentials ```
Change the access_key_id & secret with what you received from us
<br>
```[default]
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

3. Prepare the config file - <br>
In the config file we will write all the resources we need to deploy.<br>
I have prepared one in advance for you, lets check it out.<br>
```tf
C:\Users\benhay\Desktop\DevOps101\01-terraform-aws-instance>cat example.tf

provider "aws" {
	profile    = "default"
	region     = "eu-west-1"
}

resource "aws_lightsail_instance" "dell-devops-lab01" {
  name              = "dell-devops-lab01"						----> name of the server to be created
  availability_zone = "eu-west-1a"							----> In which AZ
  blueprint_id      = "amazon_linux_2018_03_0_2"			----> OS
  bundle_id         = "nano_2_0"							----> Hardware type
  tags = {													----> General key-value tags
    foo = "bar"
  }
}
```

4. After finish with code needed, we run `terraform validate` and check our config<br>
```
C:\Users\benhay\Desktop\DevOps101\01-terraform-aws-instance>terraform validate
Success! The configuration is valid.
```

5. If the config has been validated, we can apply it<br>
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
      + name               = "dell-devops-lab01"
      + private_ip_address = (known after apply)
      + public_ip_address  = (known after apply)
      + ram_size           = (known after apply)
      + tags               = {
          + "foo" = "bar"
        }
      + username           = (known after apply)
    }

Plan: 1 to add, 0 to change, 0 to destroy.

Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value: yes
  
aws_lightsail_instance.dell-devops-lab01: Creating...
aws_lightsail_instance.dell-devops-lab01: Still creating... [10s elapsed]
aws_lightsail_instance.dell-devops-lab01: Still creating... [20s elapsed]
aws_lightsail_instance.dell-devops-lab01: Still creating... [30s elapsed]
aws_lightsail_instance.dell-devops-lab01: Creation complete after 30s [id=dell-devops-lab01]

Apply complete! Resources: 1 added, 0 changed, 0 destroyed.
```

6. After several minutes we would be able to see the new lightsail server we deployed at both the AWS console<br>
and thourgh terraform cli<br>
```tf
C:\Users\benhay\Desktop\DevOps101\01-terraform-aws-instance>terraform show
# aws_lightsail_instance.dell-devops-lab01:
resource "aws_lightsail_instance" "dell-devops-lab01" {
    arn                = "arn:aws:lightsail:eu-west-1:324324095483:Instance/3de7301d-3bfa-4575-b14e-ae0c2e63955e"
    availability_zone  = "eu-west-1a"
    blueprint_id       = "amazon_linux_2018_03_0_2"
    bundle_id          = "nano_2_0"
    cpu_count          = 1
    created_at         = "2020-04-03T12:08:15Z"
    id                 = "dell-devops-lab01"
    is_static_ip       = false
    key_pair_name      = "LightsailDefaultKeyPair"
    name               = "dell-devops-lab01"
    private_ip_address = "172.26.10.39"
    public_ip_address  = "63.33.214.61"
    tags               = {
        "foo" = "bar"
    }
    username           = "ec2-user"
}
```