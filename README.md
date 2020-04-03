# DevOps101
DevOps tutorial for beginners

## Stage 0 - Git
1. Please download + install git to your computer<br>
`https://github.com/git-for-windows/git/releases/download/`

2. Open Command Line (CMD) and run:<br>
`cd %USERPROFILE%\Desktop`

3. Now we want to download the workshop's code repoistory to our computer.
Run the following:<br>
`git clone https://github.com/yanivbhemo/DevOps101.git`<br>
`cd DevOps101`

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

3. Verify the installation by entering CMD/Shell and <br>
`terraform`

### Build infrastrcture
1. Inside the repository you will find the following directory `01-terraform-aws-instance`<br>
Please enter to it.<br>
`cd learn-terraform-aws-instance`

2. Initilization phase - First action before run any new configuration<br>
`terraform init`<br>
Output:
```C:\Users\benhay\Desktop\DevOps101\01-terraform-aws-instance>terraform init

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
commands will detect it and remind you to do so if necessary.```