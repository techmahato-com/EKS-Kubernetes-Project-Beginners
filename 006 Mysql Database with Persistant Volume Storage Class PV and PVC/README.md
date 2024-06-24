# Project: EKS Storage with EBS and MySQL
By following these steps, you will have a comprehensive practice on setting up and managing storage in EKS using AWS EBS. This includes creating Storage Classes, PVCs, ConfigMaps, deploying an application with persistent storage, and managing Kubernetes manifests. This guide will help solidify your understanding and skills in using EBS for Kubernetes storage.

## Prerequisites
- AWS account with permissions to create EKS clusters, EC2 instances, and IAM roles.
- kubectl installed and configured on your local machine.
- eksctl installed on your local machine.
- helm installed on your local machine.
- An IAM user with the necessary permissions to create and manage EKS clusters.

## Step 1: Set Up EKS Cluster (Optional)
1. Create EKS Cluster:
        
        eksctl create cluster --name=eks-cluster --region=ap-south-1 --version=1.29 --nodegroup-name=my-nodes --node-type=t3.medium --managed --nodes=2 --nodes-min=2 --nodes-max=3

2. Update Kubeconfig:(Optional)
        
        aws eks update-kubeconfig --name eks-cluster --region ap-south-1

3. Verify Cluster:
    
        kubectl get nodes

## Step 2: Associate IAM Policy to Worker Node IAM Role
    - Policy Name: AmazonEBSCSIDriverPolicy


## Step 3: Install EBS CSI Driver

1. Add EBS CSI Driver Helm Repo:
       
        helm repo add aws-ebs-csi-driver https://kubernetes-sigs.github.io/aws-ebs-csi-driver
        helm repo update

2. Install EBS CSI Driver:

        helm install aws-ebs-csi-driver aws-ebs-csi-driver/aws-ebs-csi-driver --namespace kube-system

3. Verify Installation:

        kubectl get pods -n kube-system -l app.kubernetes.io/name=aws-ebs-csi-driver

## Or Install Using kubectl command (Optinal)
- Verify kubectl version, it should be 1.14 or later
        kubectl version --client --short

- Deploy Amazon EBS CSI Driver

        kubectl apply -k "github.com/kubernetes-sigs/aws-ebs-csi-driver/deploy/kubernetes/overlays/stable/?ref=master"

- Verify ebs-csi pods running
        kubectl get pods -n kube-system

## Step 3: Create Kubernetes Manifest for Storage Class, PVC, and ConfigMap

1. Create Storage Class:

        kubectl get storageclass

        vi kube-manifests/01-storage-class.yml

        kubectl apply -f kube-manifests/01-storage-class.yml

        kubectl get storageclass

2. Create Persistent Volume Claim:
        kubectl get pvc
        
        vi kube-manifests/pvc.yaml

        kubectl apply -f kube-manifests/02-persistent-volume-claim.yml
        
        kubectl get pvc

3. Create ConfigMap:

        vi kube-manifests/03-UserManagement-ConfigMap.yml

        kubectl apply -f kube-manifests/03-UserManagement-ConfigMap.yml

        kubectl get configmap usermanagement-dbcreation-script

## Step 4: Deploy MySQL with EBS Volume

1. Create MySQL Deployment:

        vi kube-manifests/04-mysql-deployment.yml

        kubectl apply -f kube-manifests/04-mysql-deployment.yml

        kubectl get pods

2. Create Cluster IP Service:

        vi kube-manifests/05-mysql-clusterip-service.yml

        kubectl apply -f kube-manifests/05-mysql-clusterip-service.yml

        kubectl get svc





        

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

