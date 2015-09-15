# DevOps Quickstart

## Part I - Launch the Orchestrator

This repo contains the bootstrap scripts to create a complete DevOps environment in an AWS account

1) Create AWS Account.  You need to manually create an AWS account and login to the console.

2) Create an Admin Role.  You need a role for the orchestrator instance. The orchestrator is simply a linux server with aws tools and scripts that will be used to bootstrap the entire cluster.  This CAN be automated with CF at some point.

3) Create a Keypair.  You need an ssh key pair for the orchestrator. Download the private key and install it where your ssh client can find it.  This can be automated with a shell script. But this assumes you have a script execution engine and now how to run scripts. It is pretty easy to do this manually.

4) Launch an Instance.  A t2.micro should do the job with the latest Amazon Linux 64 bit. Launch it with the keypair and role created in steps 2 and 3.  This can be automated with CF scripts but will need to have an AMI map with all the regions supported.

5) Login to the instance using your ssh client.

Your orchestrator is built! Test it with:

`aws ec2 --region us-west-1 describe-instances`

The orchestrator has admin rights to the ec2 account and can control all regions! Now you can start running scripts. The first thing to setup is a git repo.

`sudo yum install git`

## Part II - Code Commit

In this section we use the orchestrator instance to bootstrap our entire devops cluster

a) create a codecommit repo
```
git clone https://github.com/HansPetrie/DevOps.git
cd DevOps
./setup_repo.sh
./setup_git.sh
```
The last command will setup git with a credential helper that will use IAM roles to allow access to your git repo that was just created.

This creates the AWS code commit private repo so our orchestrator can access both public git repos and private aws repos!

If we use Cloudformation we can automate all of part II into the step from Part 5.

## Part III Code Pipeline and Jenkins

First we need a Jenkins server.

The rest of the stack contains:

VPC - Production
Public subnet (load balancers, bastion hosts, orchestrators. Nat instances)
Private subnets ()

VPC – Dev Test
Public subnets
Private subnets


