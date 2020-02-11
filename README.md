
This project allows you to bootstrap a Terraform project on AWS using Github Actions.

The purpose of the project is to make a simple sandbox for experimenting with Terraform resources using a CI pipeline.

For full details, read this article.

## Setup Steps

1. Clone the repo `git@github.com:loujaybee/terraform-aws-github-action-bootstrap.git`
2. [Install Terraform](https://www.terraform.io/downloads.html)
3. Set your bash variables locally `export AWS_ACCESS_KEY_ID=[your-key]` and `export AWS_SECRET_ACCESS_KEY=[your-key]`
4. Initialise Terraform `terraform init`
5. Update `variables.tf` and set `example-terraform-project-name` to be the name of your project
6. Execute `terraform apply` (type `yes`)
7. Uncomment the backend configuration
8. Execute `terraform init` (type `yes` to move your state)
3. Set your AWS `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY` as repo secrets @ github.com/[your-username]/[your-repo]/settings/secrets/new
4. Push to Github
