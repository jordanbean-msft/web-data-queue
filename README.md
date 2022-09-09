# web-data-queue

```shell
cd infra
terraform init

terraform plan -var-file .\env\dev.tfvars -var="admin_upn=" -var="vm_queue_username_secret_value=" -var="vm_queue_password_secret_value=" -var="sql_username_secret_value=" -var="sql_password_secret_value="

terraform apply -var-file .\env\dev.tfvars -var="admin_upn=" -var="vm_queue_username_secret_value=" -var="vm_queue_password_secret_value=" -var="sql_username_secret_value=" -var="sql_password_secret_value="
```
