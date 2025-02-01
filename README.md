# multi-env-ansible-terraform-proj
DevOps Project: Multi-Environment Infrastructure with Terraform and Ansible


DevOps Project: Multi-Environment Infrastructure with Terraform and Ansible
Introduction
This comprehensive DevOps project demonstrates how to set up a robust, multi-environment infrastructure using Terraform for provisioning and Ansible for configuration management. The project covers creating infrastructure for development, staging, and production environments, with a focus on automation, scalability, and best practices.

Project Overview
The project involves:

Installing Terraform and Ansible

Setting up AWS infrastructure

Creating dynamic inventories

Configuring Nginx across multiple environments

Automating infrastructure management

Project Diagram :

https://private-user-images.githubusercontent.com/110056716/408775110-1d7c5d29-fe0b-4ff6-9ed0-58cf8f61e520.gif?jwt=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTUiLCJleHAiOjE3MzgzODUzMDcsIm5iZiI6MTczODM4NTAwNywicGF0aCI6Ii8xMTAwNTY3MTYvNDA4Nzc1MTEwLTFkN2M1ZDI5LWZlMGItNGZmNi05ZWQwLTU4Y2Y4ZjYxZTUyMC5naWY_WC1BbXotQWxnb3JpdGhtPUFXUzQtSE1BQy1TSEEyNTYmWC1BbXotQ3JlZGVudGlhbD1BS0lBVkNPRFlMU0E1M1BRSzRaQSUyRjIwMjUwMjAxJTJGdXMtZWFzdC0xJTJGczMlMkZhd3M0X3JlcXVlc3QmWC1BbXotRGF0ZT0yMDI1MDIwMVQwNDQzMjdaJlgtQW16LUV4cGlyZXM9MzAwJlgtQW16LVNpZ25hdHVyZT1mMzBkOWNiZWRhZTQ1MTY3YjA1N2VkNWRkZDcyMjc3ZWM3MjIyMjk2Y2Y0M2MwNmJlMTc2YTc5ODU2NWI2OGYxJlgtQW16LVNpZ25lZEhlYWRlcnM9aG9zdCJ9.IneUE5SR0DL9Tkkf2O-Ugzp9tvOjz3_Zho0jDBE8wis

1. Installing Terraform and Ansible
a. Installing Terraform on Ubuntu
Follow these steps to install Terraform on Ubuntu:

Update the Package List

sudo apt-get update  
Install Dependencies

sudo apt-get install -y gnupg software-properties-common  
Add HashiCorp's GPG Key

curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg  
Add the HashiCorp Repository

echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list  
Install Terraform

sudo apt-get update && sudo apt-get install terraform  
Verify the Installation

terraform --version  
image1

b. Installing Ansible on Ubuntu
Ansible simplifies configuration management and automation. To install it:

Add the Ansible PPA

sudo apt-add-repository ppa:ansible/ansible  
Update the Package List

sudo apt update  
Install Ansible

sudo apt install ansible  
Verify the Installation

ansible --version  
image2

2. Creating Directories for Terraform and Ansible
To keep your infrastructure code and server configuration scripts organized, create two separate directories: one for Terraform and another for Ansible.

Navigate to Your Project Directory (or create a new one):

mkdir <your-project-name> && cd <your-project-name>
Create a Directory for Terraform:

mkdir terraform  
Create a Directory for Ansible:

mkdir ansible  
Verify the Directory Structure:

tree  
Your project structure should look like this:

<your-project-name>/  
├── terraform/  
└── ansible/  
With this structure, you can separate your Terraform scripts (infrastructure provisioning) and Ansible playbooks (server configuration) efficiently.

3. Setting Up Infrastructure Directory in Terraform
After creating the infra directory, add basic configurations to each Terraform file to provision essential AWS resources.

Steps to Create the Infrastructure Directory and Add File Content
Navigate to the Terraform Directory:

cd terraform  
Create the infra Directory:

mkdir infra && cd infra  
Create and Populate the Terraform Files: below is code which i have used to create infrastructure structure to accomplish project pattern

a. [bucket.tf] (S3 Bucket Configuration) : Refer to the source code provided above

b. [dynamodb.tf] (DynamoDB Table for State Locking) : Refer to the source code provided above

c. [ec2.tf] (EC2 Instance Configuration) : Refer to the source code provided above

d. [output.tf] (Output Definitions) : Refer to the source code provided above

e. [variable.tf] (Variable Declarations) : Refer to the source code provided above

Verify the File Structure and Content:

tree  
Your structure should look like this:

infra/
├── bucket.tf  
├── dynamodb.tf  
├── ec2.tf  
├── output.tf  
└── variable.tf  
Each file now contains sample resource configurations which i have used to create that project. You can modify the values in [variable.tf] to fit your project’s requirements.

4. Going Back to Terraform Directory and Adding Main Infrastructure Files
1. Go Back to the Terraform Directory
cd ..
2. Create the [main.tf] File (Using Modules for Multi-Environment Setup)
The [main.tf] file will include the configuration to call your infra module and create resources for the dev, stage, and prod environments.

Refer to the source code provided above
In this [main.tf], you're defining three modules (dev, stage, prod) using the same infra module, but you can customize them with different settings such as the EC2 instance type, AMI, S3 bucket name, and DynamoDB table name.even display output of Public ips as well.

3. Create the [providers.tf] File (AWS Provider Configuration)
This file configures the AWS provider and sets the region and access credentials.

Refer to the source code provided above
4. Create the [terraform.tf] File
This file is used for initialising terraform aws provider.

Refer to the source code provided above
5. Generate SSH Keys (devops-key and [devops-key.pub])
note : here I have used key name as devops-key , you can create with any name , and replace that every-where that old one appears,

To create SSH keys for accessing the EC2 winstances, use the ssh-keygen command:

ssh-keygen -t rsa -b 2048 -f devops-key -N ""
This generates two files:

devops-key (private key)

[devops-key.pub] (public key)

Final Directory Structure
At this point, your Terraform project structure should look like this:

├── devops-key        # Private SSH key for EC2 access
├── devops-key.pub    # Public SSH key for EC2 access
├── infra
│   ├── bucket.tf
│   ├── dynamodb.tf
│   ├── ec2.tf
│   ├── output.tf
│   └── variable.tf
├── main.tf           # Defines environment-based modules
├── providers.tf      # AWS provider configuration
├── terraform.tf      # Backend configuration for state management
Next Steps
Run Terraform Commands
Run the following commands to initialize, plan, and apply your Terraform setup:

a. terraform init : Initialize Terraform with the required providers and modules

image3

b. terraform plan : Review the plan to apply changes

image4

c. terraform apply : Apply the changes to provision infrastructur

image5

You can see below that all instance , buckets ,dynamodb are running or created , which is created through Terraform :

Instances :

image6

Buckets :

image7

DynamoDb tables:

image8

Secure the Private Key
Before using the private key, ensure that it is securely encrypted by setting proper permissions. This prevents other users from accessing it. Run the following command to restrict the access:

chmod 400 devops-key  # Set read-only permissions for the owner to ensure security
This command ensures that the private key (devops-key) is only readable by you, preventing others from accessing or modifying it.

Access EC2 Instances
After provisioning, you can SSH into the EC2 instances using the generated devops-key:

ssh -i devops-key ubuntu@<your-ec2-ip>
image9

Terraform steps done ,now going to setup with ansible

5. Creating dynamic inventories in ansible dir
Firstly nevigate to ansible dir which would you have created before

Step 1: Create the Inventories Directory
mkdir -p inventories/dev inventories/prod inventories/stg
Step 2: Add Inventory Content for Each Environment
For inventories/dev:
Refer to the source code provided above
For inventories/stg:
Refer to the source code provided above
For inventories/prod:
Refer to the source code provided above
Resulting Directory Structure
inventories
├── dev
├── prod
└── stg
6. Creating playbook for installing Nginx on all servers
Step 1: Navigate to the Ansible Directory
If you're not already in the Ansible directory, navigate to it first:

cd ../ansible
Step 2: Create the playbooks Directory
Create the playbooks directory inside the Ansible directory:

mkdir playbooks
Step 3: Navigate to the playbooks Directory
Now, navigate into the playbooks directory:

cd playbooks
Step 4: Create the install_nginx_playbook.yml File
Create the install_nginx_playbook.yml file with the following content to install Nginx and render a webpage using the nginx-role:

Refer to the source code provided above
Step 5: Verify the Directory Structure
After completing the above steps, your Ansible directory structure should look like this:

ansible
├── inventories
│   ├── dev
│   ├── prod
│   └── stg
├── playbooks
│   └── install_nginx_playbook.yml
7. Now initializing Roles for nginx named nginx-role from ansible galaxy
Here are the steps to initialize the nginx-role using Ansible Galaxy, which will generate the necessary folder structure for managing all tasks, files, handlers, templates, and variables related to the Nginx role.

Step 1: Navigate to the playbooks Directory
If you're not already in the playbooks directory, navigate to it:

cd ansible/playbooks
Step 2: Initialize the nginx-role Using Ansible Galaxy
Now, use the ansible-galaxy command to initialize the nginx-role:

ansible-galaxy role init nginx-role
This will create the following directory structure within the nginx-role folder:

nginx-role
├── README.md
├── defaults
│   └── main.yml
├── files
│   └── index.html
├── handlers
│   └── main.yml
├── meta
│   └── main.yml
├── tasks
│   └── main.yml
├── templates
├── tests
│   ├── inventory
│   └── test.yml
└── vars
    └── main.yml
Step 3: Add Custom Tasks and Files to Your nginx-role
Now that your role structure is ready, you can add your custom tasks and files.

3.1: Add tasks/main.yml
Create a tasks/main.yml file under the nginx-role/tasks/ directory. This file will contain all the steps to install, configure, and manage the Nginx service. Here's the content for your tasks/main.yml:

Refer to the source code provided above
This will ensure that:

Nginx is installed with the latest version.

Nginx service is enabled and starts automatically.

The index.html file is copied to the /var/www/html directory, which is where the default Nginx webpage is served from.

3.2: Add a Custom index.html File
You can add an index.html file under the nginx-role/files/ directory. This file can be customized as per your needs. Here's a simplified version of the index.html file you provided, with basic content:

Refer to the source code provided above
Note: You can replace this HTML content with your own custom webpage content as needed. The goal here is to serve a simple webpage as part of the Nginx configuration.

8. To add the update_inventories.sh script to your Ansible directory and integrate it with your existing setup, follow these steps:
Step 1: Create the update_inventories.sh Script
In your ansible directory, create a new file named update_inventories.sh with the following content. This script will dynamically update the inventory files for dev, stg, and prod environments based on the IPs fetched from the Terraform outputs.

Refer to the source code provided above
This script will:

Navigate to the Terraform directory and fetch the public IPs of the instances for dev, stg, and prod environments.

Dynamically generate or update the corresponding inventory files in the ansible/inventories directory.

Add common variables for all servers in each environment's inventory file.

Step 2: Verify the Directory Structure
After adding the script, your ansible directory should look like this:

ansible
├── inventories
│   ├── dev
│   ├── prod
│   └── stg
├── playbooks
│   ├── install_nginx_playbook.yml
│   └── nginx-role
│       ├── README.md
│       ├── defaults
│       │   └── main.yml
│       ├── files
│       │   └── index.html
│       ├── handlers
│       │   └── main.yml
│       ├── meta
│       │   └── main.yml
│       ├── tasks
│       │   └── main.yml
│       ├── templates
│       ├── tests
│       │   ├── inventory
│       │   └── test.yml
│       └── vars
│           └── main.yml
├── update_inventories.sh
Step 3: Make the Script Executable
Before running the update_[inventories.sh] script, ensure that it is executable. You can do this by running the following command:

chmod +x update_inventories.sh
Step 4: Run the Script
You can now execute the script to update the inventory files with the IPs fetched from Terraform:

./update_inventories.sh
Step 5: Verify the Inventory Files
After running the script, check the inventories directory. The dev, stg, and prod inventory files should now be updated with the IPs of your servers and the necessary variables.

Example contents of the dev inventory file:

[servers]
server1 ansible_host=192.168.1.10
server2 ansible_host=192.168.1.11

[servers:vars]
ansible_user=ubuntu
ansible_ssh_private_key_file=/home/amitabh/devops-key
ansible_python_interpreter=/usr/bin/python3
Repeat this process for stg and prod environments as well.

Step 6: Use the Updated Inventory in Playbooks
Now that your inventory files are updated, you can reference them in your Ansible playbooks by using the -i option:

For dev inventory :
ansible-playbook -i inventories/dev install_nginx_playbook.yml
image10

For stg inventory :
ansible-playbook -i inventories/stg install_nginx_playbook.yml
For prod inventory
ansible-playbook -i inventories/prod install_nginx_playbook.yml
This will execute the playbook using the updated all(dev,stg,prod) inventory.

Step 7: Varify the all servers whether html page is visible or not (for all inventory like : dev,stg,prod):
image11

9. Final Directory structure for this project
.
├── README.md
├── ansible
│   ├── inventories
│   │   ├── dev
│   │   ├── prod
│   │   └── stg
│   ├── playbooks
│   │   ├── install_nginx_playbook.yml
│   │   └── nginx-role
│   │       ├── README.md
│   │       ├── defaults
│   │       │   └── main.yml
│   │       ├── files
│   │       │   └── index.html
│   │       ├── handlers
│   │       │   └── main.yml
│   │       ├── meta
│   │       │   └── main.yml
│   │       ├── tasks
│   │       │   └── main.yml
│   │       ├── templates
│   │       ├── tests
│   │       │   ├── inventory
│   │       │   └── test.yml
│   │       └── vars
│   │           └── main.yml
│   └── update_inventories.sh
└── terraform
    ├── infra
    │   ├── bucket.tf
    │   ├── dynamodb.tf
    │   ├── ec2.tf
    │   ├── output.tf
    │   └── variable.tf
    ├── main.tf
    ├── providers.tf
    ├── terraform.tf
    ├── terraform.tfstate
    └── terraform.tfstate.backup
10. Infrastructure Destroy
After successfully implementing and managing your infrastructure across multiple environments with Terraform and Ansible, it's time to clean up and destroy all the resources that were provisioned. This step ensures that no resources are left running, which helps avoid unnecessary costs.

To destroy the infrastructure, follow these simple steps:

Navigate to the Terraform Directory: Go to the directory where your Terraform configuration files are located. This is typically where your main.tf file and other Terraform scripts are present.

cd /path/to/terraform/directory
Run Terraform Destroy: Execute the following command to destroy all the resources that were created by Terraform. The --auto-approve flag ensures that you won’t be prompted to confirm the destruction.

terraform destroy --auto-approve
This command will:

Destroy all EC2 instances

Delete all S3 buckets

Remove any databases or other resources provisioned during the setup

Once the command finishes executing, your infrastructure will be completely torn down, and you will have successfully cleaned up all resources.

This is the final step to ensure that you have a well-managed infrastructure setup that can be recreated anytime using Terraform and Ansible.

image12

Note: Be cautious when running terraform destroy as it will remove all resources, and data in your infrastructure will be lost. Always ensure that you’ve backed up any important data before performing the destruction.

Conclusion of the Project
Congratulations on successfully implementing and managing a multi-environment infrastructure with Terraform and Ansible! Here's a quick recap of what you've achieved:

Infrastructure Setup with Terraform:

You began by defining your infrastructure using Terraform, which included provisioning EC2 instances, S3 buckets, and databases across multiple environments: development, staging, and production.

You followed best practices in managing these resources using Terraform's modular approach and state management.

Automating Server Configuration with Ansible:

After setting up your infrastructure, you leveraged Ansible for configuration management. You initialized and structured an Nginx role using Ansible Galaxy, allowing you to efficiently manage the installation and configuration of Nginx across all environments.

You also created dynamic inventories for each environment, making it easy to manage server configurations in a scalable way.

Environment-Specific Configurations:

By dynamically fetching IPs from Terraform outputs and updating your Ansible inventories, you ensured that each environment had its own specific configuration, enabling streamlined management of resources across dev, staging, and production environments.
Simplified Infrastructure Management:

With Ansible, you automated the installation, configuration, and updates of necessary software (like Nginx), reducing manual effort and human error.

The use of Terraform and Ansible together allowed you to achieve both infrastructure provisioning and configuration management in a clean, reproducible, and automated way.

Final Cleanup:

As a final step, you executed the terraform destroy command to tear down the infrastructure that was created. This ensured that you could clean up all resources, including instances, databases, and storage, once the project was completed.
This project has provided you with hands-on experience in managing infrastructure and configurations for multiple environments using industry-standard tools like Terraform and Ansible. You have successfully automated your infrastructure management, from provisioning to configuration, across different environments.

You can now apply these skills to any real-world scenario, ensuring that infrastructure is managed efficiently, securely, and consistently across any environment.
