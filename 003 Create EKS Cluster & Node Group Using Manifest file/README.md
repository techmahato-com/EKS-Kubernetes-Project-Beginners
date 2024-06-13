To create a new EKS cluster configuration for another project based on the provided manifest, you'll need to modify certain fields such as the cluster name, node group names, subnet IDs, and project-specific tags. Below is a new manifest with comments explaining what needs to be changed:

Comments and Changes Needed:
- Cluster Name: Change metadata.name to the new project cluster name.
- Subnets: Update the subnet names and IDs in the vpc section to match the VPC configuration of your new project.
- Node Group Names: Update the name field of each managedNodeGroups entry to a new name that reflects the new project.
- AMI: Ensure the ami field is correct for your new project. If the same AMI is used, you can keep it.
- Bootstrap Command: Update the overrideBootstrapCommand to use the new cluster name.
- SSH Key: Update the publicKeyName to the new project's SSH key.
- Tags: Update tags in each tags section to reflect the new project.
- IAM Policies: Ensure any custom IAM policies are updated to reflect those used by the new project.
- Secrets Encryption: Uncomment and update the secretsEncryption section if you need to use KMS for secrets encryption.

By making these changes, you'll have a manifest ready for your new project that mirrors the configuration of the original project.



# To provision the EKS cluster using the provided eksctl manifest and verify its creation, follow these steps. Here are the AWS CLI commands you'll need:

## Install eksctl (if not already installed):
    curl --silent --location "https://github.com/weaveworks/eksctl/releases/download/v0.119.0/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp
    
    sudo mv /tmp/eksctl /usr/local/bin

## Validate the EKS cluster configuration file:
    eksctl utils validate cluster-config-file --config-file=new-project-cluster.yaml

## Create the EKS cluster: This command will create the cluster and provision all the resources defined in the manifest.
    eksctl create cluster -f new-project-cluster.yaml

## Verify the EKS cluster and node group creation: 
## Check EKS cluster status: The output should be ACTIVE.
    aws eks describe-cluster --name new-project-cluster --query 'cluster.status' --output text

## List node groups: This should list all node groups defined in your manifest.
    aws eks list-nodegroups --cluster-name new-project-cluster

## Describe each node group: Ensure that each node group status is ACTIVE
    aws eks describe-nodegroup --cluster-name new-project-cluster --nodegroup-name new-project-uat-App-NG-New-1
    aws eks describe-nodegroup --cluster-name new-project-cluster --nodegroup-name new-project-uat-App-NG-New-2
    aws eks describe-nodegroup --cluster-name new-project-cluster --nodegroup-name new-project-uat-Monitoring-NG-New-1

## Check the health of the nodes: This should list all nodes with a Ready status.
    kubectl get nodes

## Verify Addons (if applicable): If your cluster uses certain addons, verify them as well. For example:
    Check kube-proxy addon:
    
    # Check other addons similarly.

## Verify the VPC and Subnets
    aws ec2 describe-vpcs --vpc-ids <your-vpc-id>

## Check Subnets: Ensure that all subnets are correctly associated with the VPC.
    aws ec2 describe-subnets --subnet-ids subnet-0e97337aaab0e5fb0 subnet-0a7aefa0a5d5e25fa subnet-04635664c8c6d6143 subnet-054b7b620e91df94e subnet-0af2fe55da03efb37 subnet-00ce98a7614fcb436

# Verify Node IAM Roles:
## Check IAM roles:
    aws iam get-role --role-name eksctl-new-project-cluster-nodegroup-new-project-uat-App-NG-New-1-NodeInstanceRole-xxxxxxx

## Verify Logging (if enabled):
    aws logs describe-log-groups --log-group-name-prefix /aws/eks/new-project-cluster/cluster














