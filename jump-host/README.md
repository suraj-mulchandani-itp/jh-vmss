# Azure JumpHost Infrastructure Module

Terraform module that setups Jump Boxes in the Hub Network.

## Terraform Commands

- Setup Pre-requisite environment variables

  ```shell
    export ENVIRONMENT=shared
    export PREFIX=es
    export INFRA_TYPE=jumpbox
  ```

- Initialize to terraform modules

    ```
    terraform init --backend-config=azure.conf -backend-config="key=$PREFIX-$ENVIRONMENT-$INFRA_TYPE"
    ```

- Setup terraform workspace

    ```
    terraform workspace new $PREFIX-$ENVIRONMENT-$INFRA_TYPE
  
    # make sure the correct workspace is selected
    terraform workspace select $PREFIX-$ENVIRONMENT-$INFRA_TYPE
    ```

- Plan the infrastructure

    ```
    # Modify the values in terraform.example.tfvars and copy it to a new file  
    # cp terraform.example.tfvars env/$ENVIRONMENT.tfvars
    terraform plan --var-file=env/$ENVIRONMENT.tfvars --out $PREFIX-$ENVIRONMENT-$INFRA_TYPE.plan
    ```
- Apply the infrastructure

    ```
     terraform apply "$PREFIX-$ENVIRONMENT-$INFRA_TYPE.plan"
    ```
  
- Destroy the infrastructure

    ```
    terraform destroy --var-file=env/$ENVIRONMENT.tfvars
    ```


