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
1. Please download Terraform on your computer - <br>
`https://www.terraform.io/downloads.html`

2. Unzip the package and save the binary in the following - <br>
`Windows: C:\Windows\System32`
`Linux: /usr/local/bin`