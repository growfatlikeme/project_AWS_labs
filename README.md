# Sample on-demand AWS resource provionsioning with terraform

## 📌 Get Started

`git clone https://github.com/growfatlikeme/project_AWS_labs`

> [!IMPORTANT]
> Keypair.tf is not uploaded, and should be created on your own.
> It defines the keypair I am using for instances that I can SSH into using a locally available private.pem file, and uploading the public .pem file onto AWS.

> [!NOTE]
> Variables are defined in ndev.tfvars, for future flexibility to invoke another environment with different value such as for QA, Prod in another .tfvars file.

## :sunglasses: Creation of Resources :running:

### **_VPC only (VPC 1)_**

`cd vpc_only_nongw` <br>
`terraform init` <br>
`terraform plan -var-file="ndev.tfvars" ` <br>
`terraform apply -var-file="ndev.tfvars"` <br>

Input `true` or `false` for creation of Nat Gateway resource <br>

... <br>

`terraform destroy -var-file="ndev.tfvars" `<br>

### **_VPC only (VPC 2)_**

`cd vpc_only_nongw_2` <br>
`terraform init` <br>
`terraform plan -var-file="ndev.tfvars" ` <br>
`terraform apply -var-file="ndev.tfvars"` <br>

Input `true` or `false` for creation of Nat Gateway resource <br>

... <br>

`terraform destroy -var-file="ndev.tfvars" `<br>

### **_VPC + Jumphost only_**

Run VPC 1. <br>

`cd ../ec2_bastion_withVPC` <br>
`terraform init` <br>
`terraform plan -var-file="ndev.tfvars" ` <br>
`terraform apply -var-file="ndev.tfvars"` <br>

... <br>

`terraform destroy -var-file="ndev.tfvars" `<br>

`cd ../vpc_only_nongw` <br>
`terraform destroy -var-file="ndev.tfvars" `<br>

Input `false` for creation of Nat Gateway resource <br>

### **_S3 bucket site hosting with cloudfront and WAF_**

`cd ../s3_hosting_cloudfront` <br>
`terraform init` <br>
`terraform plan -var-file="ndev.tfvars" ` <br>
`terraform apply -var-file="ndev.tfvars"` <br>
`terraform destroy -var-file="ndev.tfvars" `<br>

### **_AWS SNS Topic_**

`cd ../sns_topic` <br>
`terraform init` <br>
`terraform plan -var-file="ndev.tfvars" ` <br>
`terraform apply -var-file="ndev.tfvars"` <br>
`terraform destroy -var-file="ndev.tfvars" `<br>

### **_DynamoDB table with sample data_**

`cd ../dynamodb` <br>
`terraform init` <br>
`terraform plan -var-file="ndev.tfvars" ` <br>
`terraform apply -var-file="ndev.tfvars"` <br>
`terraform destroy -var-file="ndev.tfvars" `<br>

### **_MySQL accessible from private subnet only_**

Run VPC 1. <br>

`cd ../mySQL` <br>
`terraform init` <br>
`terraform plan -var-file="ndev.tfvars" ` <br>
`terraform apply -var-file="ndev.tfvars"` <br>
`terraform destroy -var-file="ndev.tfvars" `<br>

... <br>

`cd ../vpc_only_nongw` <br>
`terraform destroy -var-file="ndev.tfvars" `<br>

Input `false` for creation of Nat Gateway resource <br>

### **_VPC Peering_**

Run VPC 1. <br>

Run VPC 2. <br>

`cd ../vpc_peering` <br>
`terraform init` <br>
`terraform plan -var-file="ndev.tfvars" ` <br>
`terraform apply -var-file="ndev.tfvars"` <br>
`terraform destroy -var-file="ndev.tfvars" `<br>

... <br>

`cd ../vpc_only_nongw_2` <br>
`terraform destroy -var-file="ndev.tfvars" `<br>

Input `false` for creation of Nat Gateway resource <br>

`cd ../vpc_only_nongw` <br>
`terraform destroy -var-file="ndev.tfvars" `<br>

Input `false` for creation of Nat Gateway resource <br>

### **_iam_role_**

`cd ../iam_role` <br>
`terraform init` <br>
`terraform plan -var-file="ndev.tfvars" ` <br>
`terraform apply -var-file="ndev.tfvars"` <br>
`terraform destroy -var-file="ndev.tfvars" `<br>

To test, run ec2 instance from vpc2 which dynamically assign role if policy exist. <br>

### **_EBS volume_**

`cd ../ebs` <br>
`terraform init` <br>
`terraform plan -var-file="ndev.tfvars" ` <br>
`terraform apply -var-file="ndev.tfvars"` <br>
`terraform destroy -var-file="ndev.tfvars" `<br>

To test, re-apply terraform for ec2 instance from vpc1. <br>
