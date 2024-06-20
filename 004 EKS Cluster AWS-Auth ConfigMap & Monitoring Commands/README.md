
# Commands for monitoring and checking the status of your AWS EKS cluster, node groups, pods, services, namespaces, etc.

1. List EKS Clusters
    aws eks list-clusters

2. Verify Cluster Status
    aws eks describe-cluster --name <your-cluster-name> --query 'cluster.status' --output text

3. Describe Cluster
    aws eks describe-cluster --name <your-cluster-name>

4. Check Kubernetes Version
    kubectl version

5. Check Namespaces
    kubectl get ns
    kubectl describe namespace <namespace-name>

6. Check Pods
    kubectl get pods -n <namespace-name>
    kubectl describe pod <pod-name> -n <namespace-name>
    kubectl get pods -n <namespace-name> -o wide

7. Check Services
    kubectl get services -n <namespace-name>
    kubectl describe service <service-name> -n <namespace-name>

8. Check Node Groups
    eksctl get nodegroups --cluster=<cluster-name>
    aws eks describe-nodegroup --cluster-name <cluster-name> --nodegroup-name <nodegroup-name> --query 'nodegroup.status' --output text

9. Check Kubernetes Nodes
    kubectl get nodes
    kubectl describe node <node-name>
    # list nodes in a specific node group:
    kubectl get nodes -l eks.amazonaws.com/nodegroup=<nodegroup-name>  
    # List pods scheduled on nodes in a node group:
    kubectl get pods -o wide --field-selector spec.nodeName=<node-name> 

10. Check System Pods
Verify that all system pods (like CoreDNS) are running:



kubectl get pods -n kube-system
11. Verify EKS Addons
List all addons for a cluster:



aws eks list-addons --cluster-name <cluster-name>
Describe the status of a specific addon:



aws eks describe-addon --cluster-name <cluster-name> --addon-name <addon-name> --query 'addon.status' --output text
Replace <cluster-name> and <addon-name> with the respective cluster and addon name.

12. Check Kubernetes Services
Verify that Kubernetes services are running correctly:



kubectl get services -A
13. Check Logging Configuration
Ensure logging is enabled and check logs for any issues:



aws eks describe-cluster --name <cluster-name> --query 'cluster.logging'
Replace <cluster-name> with the name of your cluster.

14. Check Cluster Autoscaler
If you are using the Cluster Autoscaler, ensure it is running properly:



kubectl get pods -n kube-system | grep cluster-autoscaler
15. Verify IAM Roles
Ensure that the necessary IAM roles and policies are attached correctly:



aws iam list-roles | grep <role-name>
Replace <role-name> with the name of your IAM role.

16. Check Load Balancer
If you have deployed a load balancer, ensure it is functioning correctly:



kubectl get svc -o wide















