# Azure Jumpbox Example
An example demonstrating the usage of azure-jumpbox-vm module.

## Terraform Commands

- Initialize to terraform modules

    ```
    terraform init
    ```
- Plan the infrastructure

    ```
    terraform plan --out az_jumphost.plan
    ```
- Apply the infrastructure

    ```
     terraform apply "az_jumphost.plan"
    ```
- Destroy the infrastructure

    ```
    terraform destroy
    ```
