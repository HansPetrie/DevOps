# DevOps Quickstart

## Part I - Launch the Orchestrator

This repo contains the bootstrap scripts to create a complete DevOps environment in an AWS account

1) Create AWS Account.  You need to manually create an AWS account and login to the console.

2) Create a Keypair.  For security you need an ssh key pair for the orchestrator. Download the private key and install it where your ssh client can find it.  The keypair is used to log in to the orchestrator for debugging purposes.  The private key should be kept secure and is not used by anyone but you.

3) Launch the Cloudformation template.  Fill out the parameters.

* StackName - Must be Unique.  Don't use any special characters.  A good example is DevOps.
* Key - Select the keypair from the dropdown.
* IAM Role - Be sure to check the box so that the cloudformation template can build the necessary roles

What this template does:

1) Creates an Admin role and instance profile used by the orchestrator instance to do automation.
2) Creates a CodePipeline role used by CodePipeline to automate code delivery.
3) Launches a t2.micro in us-east-1 default VPC with a web server security group locked down to the IP provided as an input.  Note that the default of 0.0.0.0/0 is open to the world and should not be used although it is adequate for short tests.  When launched the instance installs git and runs ./install.sh from the repo.  Everything else is done from the instance.

Instance Automation:

1) Sets up a CodeCommit repo and local git with credential helper.
2) Sets up Jenkins on port 8080.
3) Sets up Jenkins httpd proxy (using Apache) on port 80.
4) Sets up CodePipeline Jenkins plug-in and MyDemoApp job.
5) Sets up a bucket for use with CodePipeline.
6) Sets up CodePipeline with source s3 bucket and Jenkins MyDemoApp build.

## Part II Code Pipeline and Jenkins

When the Cloudformation has completed the outputs will show a URL to your Jenkins host.  You can click this URL and go directly to Jenkins.  Here you will see it should be spinning off a demo build.  NOTE: It can take up to a minute for Jenkins to stabalize due to a restart during the installation process.  If you get a service unavailable you may have to wait.

## Part III Troubleshooting

On the orchestrator check /var/log/cloud-init-output.log for errors.  The scripts are all located in /DevOps/ which is a clone of the git repo.
