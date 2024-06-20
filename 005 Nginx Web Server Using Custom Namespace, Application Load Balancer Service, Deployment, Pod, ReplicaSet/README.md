
# Project 5: EKS Cluster - Nginx Web Server Using Custom Namespace, Application Load Balancer Service, Deployment, Pod, ReplicaSet
### This project will guide you through deploying an Nginx web server on an EKS cluster using a custom namespace. You will use various Kubernetes objects like Deployment, ReplicaSet, and Services, including setting up an Application Load Balancer (ALB)

1. Prerequisites
    - AWS CLI configured with appropriate IAM permissions.
    - kubectl installed and configured to interact with your EKS cluster.
    - eksctl installed.
    - AWS Load Balancer Controller installed in the cluster.

2. Step 1: Setup EKS Cluster: If you don't have an EKS cluster yet, create one using eksctl:
    
        eksctl create cluster --name my-eks-cluster --version 1.21 --region us-west-2 --nodegroup-name linux-nodes -node-type t3.medium --nodes 3 --nodes-min 1 --nodes-max 4 --managed

3. Step 2: Create Custom Namespace: Create a custom namespace for your Nginx web server:
    
        kubectl create namespace my-namespace

4. Step 3: Create Deployment: Create a Deployment YAML file (nginx-deployment.yaml) to deploy the Nginx web server:
    
        kubectl apply -f nginx-deployment.yaml

5. Step 4: Expose Deployment as a Service: Create a Service YAML file (nginx-service.yaml) to expose the Deployment using an Application Load Balancer:

        kubectl apply -f nginx-service.yaml

6. Step 5: Setup Ingress Controller and Ingress Resource:

Install AWS Load Balancer Controller: Follow the instructions to install the AWS Load Balancer Controller if not already installed. Ensure your cluster has the required IAM policies.

Create an Ingress Resource: Create an Ingress YAML file (nginx-ingress.yaml) to route traffic to the Nginx Service:

        kubectl apply -f nginx-ingress.yaml

7. Step 6: Verify the Deployment
    - Check Pods: Ensure all pods are running

            get pods -n my-namespace

    - Check Ingress: Ensure the Ingress is created and has an address:

            kubectl get ingress -n my-namespace

    - Test the Application: Access your application using the DNS name associated with your ALB:

            curl http://my-nginx-app.example.com

You should see the Nginx welcome page.

Conclusion
By following these steps, you have successfully deployed an Nginx web server on an EKS cluster using a custom namespace, Application Load Balancer service, deployment, and other Kubernetes resources. This setup demonstrates a typical use case for deploying web applications in a scalable and managed environment using Kubernetes and AWS EKS.