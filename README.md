# Sample and basic Modular AWS resource provionsioning with terraform

## 📌 Get Started

`git clone https://github.com/growfatlikeme/project_AWS_labs`

> [!IMPORTANT]
> Keypair.tf is not uploaded, and should be created on your own.
> It defines the keypair I am using for instances that I can SSH into using a locally available private.pem file, and uploading the public .pem file onto AWS.

> [!NOTE]
> Variables are defined in ndev.tfvars, for future flexibility to invoke another environment with different value such as for QA, Prod in another .tfvars file.

## :running: Running the code locally

`terraform init` <br>
`terraform plan -var-file="ndev.tfvars" ` <br>
`terraform apply -var-file="ndev.tfvars"` <br>
`terraform destroy -var-file="dev.tfvars" `<br>

## :sunglasses: Creation of Resources

**_Step 1 - VPC only_** <br>
`cd vpc_only_nongw` <br>
`terraform init` <br>
`terraform plan -var-file="ndev.tfvars" ` <br>
`terraform apply -var-file="ndev.tfvars"` <br>
`terraform destroy -var-file="dev.tfvars" `<br>

**_Step 2 - VPC + Jumphost only_** <br>

Do step 1. <br>

`cd ../ec2_bastion_withVPC` <br>
`terraform init` <br>
`terraform plan -var-file="ndev.tfvars" ` <br>
`terraform apply -var-file="ndev.tfvars"` <br>
`terraform destroy -var-file="dev.tfvars" `<br>
