# <a name="_64jf9ank4ga8"></a>**Monitoring AWS EKS using Prometheus and Grafana**
This guide will walk you through setting up monitoring for your AWS EKS cluster using Prometheus and Grafana.

[**Monitoring AWS EKS using Prometheus and Grafana**	](#_64jf9ank4ga8)**1****

[**Table of Contents**](#_ilzl9hxincdg)[	](#_ilzl9hxincdg)1

[1. What is Amazon EKS?	](#_8517urv2w6bx)2

[2. What is Grafana?	](#_oxdue0jix5od)2

[3. What is Prometheus?	](#_he8ks35lqsjf)2

[4. Why Use Helm?	](#_5kqvporz25t7)2

[5. Prerequisites	](#_oxj603wmrlwy)3

[6. Step-by-Step Setup Guide	](#_vy3bt6xhn24k)3

[Step 1: Install and Setup kubectl on Ubuntu Server	](#_dcj2fa3aloyq)3

[Step 2: Install and Setup eksctl on Ubuntu Server	](#_yfcnvcdfcz5r)3

[Step 3: Install Helm on Ubuntu Server	](#_jp9t91bt5ano)3

[Step 4: Create an Amazon EKS Cluster using eksctl	](#_tkaln2nw4ie0)4

[Step 5: Add Helm Stable Charts for Your Local Client	](#_qt2376tp2eh)4

[Step 6: Add Prometheus Helm Repository	](#_p80a47sau760)5

[Step 7: Create Prometheus Namespace	](#_e1oa7adnwhj6)5

[Step 8: Install Prometheus using Helm	](#_ynh8brt5246e)5

[Step 9: Expose Prometheus and Grafana to the External World	](#_oo4qce4wjnsl)5

[Step 10: Clean Up / Deprovision - Deleting the Cluster	](#_olf2bc3vjw5q)6

[Conclusion	](#_krsrqzhiqd8y)6

## <a name="_8517urv2w6bx"></a>**1. What is Amazon EKS?**
Amazon Elastic Kubernetes Service (EKS) is a managed service that makes it easy to run Kubernetes on AWS without needing to install and operate your own Kubernetes control plane or nodes.
## <a name="_oxdue0jix5od"></a>**2. What is Grafana?**
Grafana is an open-source platform for monitoring and observability. It allows you to query, visualize, alert on, and understand your metrics no matter where they are stored.
## <a name="_he8ks35lqsjf"></a>**3. What is Prometheus?**
Prometheus is an open-source monitoring and alerting toolkit designed for reliability and scalability. It is commonly used to collect and store metrics, enabling monitoring and alerting for various applications.
## <a name="_5kqvporz25t7"></a>**4. Why Use Helm?**
Helm is a package manager for Kubernetes that simplifies the deployment and management of applications within a Kubernetes cluster. Helm uses charts to define, install, and upgrade complex Kubernetes applications.
## <a name="_oxj603wmrlwy"></a>**5. Prerequisites**
- AWS CLI configured with appropriate IAM permissions.
- kubectl installed and configured to interact with your EKS cluster.
- eksctl installed.
- Helm installed.
- AWS Load Balancer Controller installed in the cluster.
## <a name="_vy3bt6xhn24k"></a>**6. Step-by-Step Setup Guide**
### <a name="_dcj2fa3aloyq"></a>**Step 1: Install and Setup kubectl on Ubuntu Server**
Installing and setting up kubectl configures the command-line interface essential for managing Kubernetes clusters.

|sudo curl --silent --location -o /usr/local/bin/kubectl https://s3.us-west-2.amazonaws.com/amazon-eks/1.22.6/2022-03-09/bin/linux/amd64/kubectl<br>sudo chmod +x /usr/local/bin/kubectl<br>kubectl version --short --client|
| :- |

### <a name="_yfcnvcdfcz5r"></a>**Step 2: Install and Setup eksctl on Ubuntu Server**
Installing and setting up eksctl simplifies the process of creating and managing Amazon EKS clusters with its command-line utility.

|curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl\_$(uname -s)\_amd64.tar.gz" | tar xz -C /tmp<br>sudo mv /tmp/eksctl /usr/local/bin<br>eksctl version|
| :- |
### <a name="_jp9t91bt5ano"></a>**Step 3: Install Helm on Ubuntu Server**
Installing Helm Charts involves deploying pre-configured packages onto Kubernetes clusters.

|curl -fsSL -o get\_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3<br>chmod 700 get\_helm.sh<br>./get\_helm.sh|
| :- |

Verify the Helm installation:

|helm version|
| :- |
### <a name="_tkaln2nw4ie0"></a>**Step 4: Create an Amazon EKS Cluster using eksctl**
Creating an Amazon EKS Cluster using eksctl streamlines the process of setting up and managing Kubernetes clusters on AWS.

|eksctl create cluster --name=eks-cluster --region=ap-south-1 --version=1.29 --nodegroup-name=my-nodes --node-type=t3.medium --managed --nodes=2 --nodes-min=2 --nodes-max=3|
| :- |

This process takes 15–20 minutes. Verify the cluster by logging into the AWS Console or using the following command:

|eksctl get cluster --name eks-cluster --region ap-south-1|
| :- |

Update Kube config:

|aws eks update-kubeconfig --name eks-cluster --region ap-south-1|
| :- |

Connect to EKS cluster and view worker nodes:

|kubectl get nodes<br>kubectl get ns|
| :- |
### <a name="_qt2376tp2eh"></a>**Step 5: Add Helm Stable Charts for Your Local Client**
Add the Helm Stable Charts for your local client.

|helm repo add stable https://charts.helm.sh/stable|
| :- |
### <a name="_p80a47sau760"></a>**Step 6: Add Prometheus Helm Repository**
Add the Prometheus Helm Repository.

|helm repo add prometheus-community https://prometheus-community.github.io/helm-charts|
| :- |
### <a name="_e1oa7adnwhj6"></a>**Step 7: Create Prometheus Namespace**
Create a namespace for Prometheus.

|kubectl create namespace prometheus<br>kubectl get ns|
| :- |
### <a name="_ynh8brt5246e"></a>**Step 8: Install Prometheus using Helm**
Install Prometheus using Helm. The kube-prometheus-stack includes both Prometheus and Grafana.

|helm install prometheus prometheus-community/kube-prometheus-stack -n prometheus|
| :- |

Verify the installation:

|kubectl get pods -n prometheus<br>kubectl get svc -n prometheus|
| :- |
### <a name="_oo4qce4wjnsl"></a>**Step 9: Expose Prometheus and Grafana to the External World**
To expose Prometheus and Grafana, change the service type from ClusterIP to LoadBalancer.

Edit the Prometheus service:

|kubectl edit svc prometheus-kube-prometheus-prometheus -n prometheus|
| :- |

Change type: ClusterIP to type: LoadBalancer and save the file.

Edit the Grafana service:

|kubectl edit svc prometheus-grafana -n prometheus|
| :- |

Change type: ClusterIP to type: LoadBalancer and save the file.

Check the services:

|kubectl get svc -n prometheus|
| :- |
### <a name="_olf2bc3vjw5q"></a>**Step 10: Clean Up / Deprovision - Deleting the Cluster**
Delete the EKS cluster and all associated resources.

|eksctl delete cluster --name eks-cluster|
| :- |
## <a name="_krsrqzhiqd8y"></a>**Conclusion**
Setting up Prometheus and Grafana dashboards for monitoring AWS EKS offers a robust solution for observing and managing your Kubernetes clusters. With Prometheus collecting metrics and Grafana providing visualization capabilities, users gain insights into cluster health, resource utilization, and performance metrics.























