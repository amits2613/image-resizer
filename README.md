** Infrastructure provisioning**

Terraform being used to provision infrastructure on AWS. Terraform state file being stored it locally, if require can be uploded to remote S3 bucket to store terraform state file

``` terraform init -var-file=var.tfvars
    terrafrom plan -var-file=var.tfvars
    terraform apply -var-file=var.tfvars
```

** Application deployment **

Application has been deployed as container in AWS lambda function. Docker image is build and pushed in AWS ECR

** CI/CD **

Github Actions used for CI/CD. It trigger the pipeline whenever push event occur in master branch.  

** How to access application **

Lambda function will generate a https url and that can be used to invoke lambda function from internet or postman.

``` https://<url-id>.lambda-url.<region>.on.aws ```

After applying terraform, it prints the function url on console
