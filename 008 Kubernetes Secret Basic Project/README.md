Step-by-Step Guide to Practice Kubernetes Secrets
# Step 1: Create a Kubernetes Cluster (if not already created)
If you haven't already created a Kubernetes cluster, you can create one using AWS EKS.

Create EKS Cluster and Node Group: Use AWS Management Console or AWS CLI to create an EKS cluster and node group.

# Step 2: Install kubectl
Ensure kubectl is installed and configured to interact with your cluster.

# Step 3: Create a Namespace
Create a namespace to isolate your resources.
        - kubectl create namespace secret-demo

# Step 4: Create a Kubernetes Secret
Kubernetes Secrets are used to store and manage sensitive information, such as passwords, OAuth tokens, and ssh keys.

Create a secret using kubectl:
        - kubectl create secret generic db-secret --from-literal=username=myuser --from-literal=password=mypassword -n secret-demo

Create a secret using Yaml:
        - kubectl apply -f secret.yaml

Step 5: Deploy a Sample Application
Deploy a sample application that uses the secret.

Create a Deployment YAML file:
    kubectl apply -f deployment.yaml

# Step 6: Verify the Secret is Used by the Pod
Verify that the secret is correctly used by the application pod.

Get the pods:
        kubectl get pods -n secret-demo

Check the environment variables in the running pod:

        kubectl exec -it <pod-name> -n secret-demo -- env | grep DB_

Replace <pod-name> with the name of your pod.

# Step 7: Clean Up
Clean up the resources after practice.
        kubectl delete namespace secret-demo

This guide will help you practice creating and using Kubernetes Secrets in a sample project. You can extend this project by adding more complex scenarios, such as using Secrets with ConfigMaps or mounting Secrets as files in pods.

