# Sample on-demand AWS resource provionsioning with terraform

## 📌 Get Started

`git clone https://github.com/growfatlikeme/project_AWS_labs`

> [!IMPORTANT]
> Keypair.tf is not uploaded, and should be created on your own.
> It defines the keypair I am using for instances that I can SSH into using a locally available private.pem file, and uploading the public .pem file onto AWS.

> [!NOTE]
> Variables are defined in ndev.tfvars, for future flexibility to invoke another environment with different value such as for QA, Prod in another .tfvars file.

## :sunglasses: Creation of Resources :running:

###**_Step 1 - VPC only_**###

`cd vpc_only_nongw` <br>
`terraform init` <br>
`terraform plan -var-file="ndev.tfvars" ` <br>
`terraform apply -var-file="ndev.tfvars"` <br>
Input `true` or `false` for creation of Nat Gateway resource <br>
... <br>
`terraform destroy -var-file="ndev.tfvars" `<br>

###**_Step 2 - VPC + Jumphost only_**###

Do step 1. <br>

`cd ../ec2_bastion_withVPC` <br>
`terraform init` <br>
`terraform plan -var-file="ndev.tfvars" ` <br>
`terraform apply -var-file="ndev.tfvars"` <br>
... <br>
`terraform destroy -var-file="ndev.tfvars" `<br>
Input `false` for creation of Nat Gateway resource <br>
`cd ../vpc_only_nongw` <br>
`terraform destroy -var-file="ndev.tfvars" `<br>
