# To deploy in a perticular  environment (env-dev or env-prod):
1. Go inside that directory:
   example:-
    cd env-dev

2. Run terraform comand from there:
   terraform init
   terraform plan 
   terraform apply (it should create 24 resources)

======================================================================
HOW TO DEPLOY TERRAFORM CODE USING JENKINS PIPELINE
---------------------------------------------------
1. Install "Terraform" plugin in Jenkins:
   Jenkins Home --> Manage Jenkins ---> Manage Plugins ---> Available Plugins --> Search for Terraform plugin and install it.

2. Install Terraform Binary:
   Navigate to Dashboard > Manage Jenkins > Global Tool Configuration” page, and scroll to the Terraform section