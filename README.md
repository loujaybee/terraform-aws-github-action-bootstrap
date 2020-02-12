
This project allows you to bootstrap a Terraform project on AWS using Github Actions.

The purpose of the project is to make a simple sandbox for experimenting with Terraform resources using a CI pipeline.

For full details, read this article.

## Setup Steps

Pre-requisites: 
* A setup AWS account
* Git installed on your machine

### Step 1: Create the backend bucket

1. Clone the repo `git@github.com:loujaybee/terraform-aws-github-action-bootstrap.git`
2. Install the [Terraform](https://www.terraform.io/downloads.html) binary
3. Set your bash variables locally 
    * `export AWS_ACCESS_KEY_ID=[your-key]` 
    * `export AWS_SECRET_ACCESS_KEY=[your-key]`
4. `terraform init` to initialise Terraform 
5. Update the `main.tf` file and set `bucket` property of the backend and s3 resource blocks (yes, even the one that's commented out, we'll need it as part of step 8)
6. Execute `terraform apply` (type `yes`)

### Step 2: Run Terrafrom on Github Actions

7. Uncomment the backend configuration in `main.tf` 
8. Execute `terraform init` (type `yes` to move your state)
9. Set your AWS `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY` as repo secrets @ github.com/[your-username]/[your-repo]/settings/secrets/new
10. `git add .` and `git commit -m "First commit"` to commit any changes
11. `git push` to push to github

## Having Problems?

[Raise an issue](https://github.com/loujaybee/terraform-aws-github-action-bootstrap/issues)
