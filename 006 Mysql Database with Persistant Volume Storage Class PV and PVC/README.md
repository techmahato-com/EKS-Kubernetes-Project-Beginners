# Project: EKS Storage with EBS and MySQL
By following these steps, you will have a comprehensive practice on setting up and managing storage in EKS using AWS EBS. This includes creating Storage Classes, PVCs, ConfigMaps, deploying an application with persistent storage, and managing Kubernetes manifests. This guide will help solidify your understanding and skills in using EBS for Kubernetes storage.

## Prerequisites
- AWS account with permissions to create EKS clusters, EC2 instances, and IAM roles.
- kubectl installed and configured on your local machine.
- eksctl installed on your local machine.
- helm installed on your local machine.
- An IAM user with the necessary permissions to create and manage EKS clusters.

## Step 1: Set Up EKS Cluster
1. Create EKS Cluster:
    eksctl create cluster --name=eks-cluster --region=ap-south-1 --version=1.29 --nodegroup-name=my-nodes --node-type=t3.medium --managed --nodes=2 --nodes-min=2 --nodes-max=3

2. Update Kubeconfig:
    aws eks update-kubeconfig --name eks-cluster --region ap-south-1

3. Verify Cluster:
    kubectl get nodes

## Step 2: Install EBS CSI Driver

1. Add EBS CSI Driver Helm Repo:
    helm repo add aws-ebs-csi-driver https://kubernetes-sigs.github.io/aws-ebs-csi-driver
    helm repo update

2. Install EBS CSI Driver:

    helm install aws-ebs-csi-driver aws-ebs-csi-driver/aws-ebs-csi-driver --namespace kube-system

3. Verify Installation:

    kubectl get pods -n kube-system -l app.kubernetes.io/name=aws-ebs-csi-driver

## Step 3: Create Storage Class, PVC, and ConfigMap

1. Create Storage Class:

    vi storageclass.yaml

    kubectl apply -f storageclass.yaml

2. Create Persistent Volume Claim:

    vi pvc.yaml

    kubectl apply -f pvc.yaml


3. Create ConfigMap:

    vi configmap.yaml

    kubectl apply -f configmap.yaml

## Step 4: Deploy MySQL with EBS Volume

1. Create MySQL Deployment:

    vi mysql-deployment.yaml

    kubectl apply -f mysql-deployment.yaml

2. Create Cluster IP Service:

    vi mysql-service.yaml

    kubectl apply -f mysql-service.yaml

## Step 5: Test MySQL Deployment

1. Get MySQL Pod Name:

    kubectl get pods -l app=mysql

2. Exec into MySQL Pod:

    kubectl exec -it <mysql-pod-name> -- mysql -u root -p

Enter the password as password and test the database connection.

## Step 6: Clean Up Resources

1. Delete MySQL Deployment and Service:

    kubectl delete -f mysql-deployment.yaml
    kubectl delete -f mysql-service.yaml


2. Delete PVC and ConfigMap:

    kubectl delete -f pvc.yaml
    kubectl delete -f configmap.yaml

3. Delete Storage Class:

    kubectl delete -f storageclass.yaml

4. Uninstall EBS CSI Driver:

    helm uninstall aws-ebs-csi-driver --namespace kube-system

5. Delete EKS Cluster:

    eksctl delete cluster --name eks-cluster

