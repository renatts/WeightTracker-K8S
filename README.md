# Node.js Weight Tracker with <img height="40px" src="https://user-images.githubusercontent.com/83014719/141646019-0eefacfd-8315-4fde-a667-6d7aa3aa12e1.PNG"> & <img height="40px" src="https://www.vectorlogo.zone/logos/kubernetes/kubernetes-icon.svg">

[![Build Status](https://dev.azure.com/parennut/Weight-Tracker-CICD/_apis/build/status/renatts.WeightTracker-Docker?branchName=master)](https://dev.azure.com/parennut/Weight-Tracker-CICD/_build/latest?definitionId=4&branchName=master)

##  Infrastructure requirements
<img width="500" height="200" src="https://user-images.githubusercontent.com/83014719/142743760-be29b5dc-819e-412a-9e3b-4d43673a7404.png">
<img width="500" height="200" src="https://user-images.githubusercontent.com/83014719/142743761-af2dad40-18d6-446a-be2a-ccc8bae640fa.png">


## Create the agent machine 

###  Install Docker on the agent virtual machine using this commands
* `sudo apt-get update`
* `sudo apt-get upgrade`
* `sudo apt install docker.io`
* `systemctl start docker`
* `systemctl enable docker`
* `docker --version` - for checking docker version on virtual machine

### Give docker necessary permissions
* `sudo usermod -a -G docker $USER`
* `sudo reboot`

## Create Azure Container Registry
* Create [Azure Container Registry](https://portal.azure.com/#create/Microsoft.ContainerRegistry) for storing containers in remote repositories


## Create Azure Kubernetes Service
* Create [Azure Kubernetes Cluster](https://portal.azure.com/#create/microsoft.aks)

### Install Nginx Ingress to your kubernetes cluster using this commands in Azure CLI:
* `az login`
* `NAMESPACE=ingress-nginx`
* `helm install ingress-nginx ingress-nginx/ingress-nginx --create-namespace --namespace $NAMESPACE`
* `helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx`
* `helm repo update`
* `kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.0.4/deploy/static/provider/cloud/deploy.yaml`

## Create PostgreSQL service
* Create [PostgreSQL](https://portal.azure.com/#create/Microsoft.PostgreSQLServer) service in [Azure portal](https://portal.azure.com)
* Add firewall rules

---
##  CI/CD pipeline requirements
<img width="550" alt="docker-cicd" src="https://user-images.githubusercontent.com/83014719/142743862-3c90bf61-bab6-4287-bb4a-d016706c1fa2.png">

### Part I
* Configure agent pool (self-hosted)
* Create `azure-pipelines.yaml` file
* Create stages: `Build, Deploy to Staging, Deploy to Production` 
* On stage `Build` add `Push` task for pushing the build to [ACR](https://azure.microsoft.com/en-us/services/container-registry/#overview) (Azure Container Registry) repository.
* On Deploy stages add `imagePullSecret` task for pulling the latest pushed image from [ACR](https://azure.microsoft.com/en-us/services/container-registry/#overview) repository.
* Create variables group for each environment in Library.
* Create `configMap` and `secrets`
* Create `Deploy to Cluster` task that will deploy the containers from the ACR to your AKS cluster according to given manifests and imagePullSecrets.

### Part II
* In your `azure-pipelines.yaml` file add a condition for triggering the Deploy stages only from `master` branch.
* Create branch with `feature/` prefix.
* Unlike `master` branch, the `feature` branch must trigger only the CI (Build and Push).
* Create branch policy to not be able to push changes into the `master` branch.
* Run your pipeline on `feature/*` branch.
* Check your pipeline (must skip the deployment stages).
* Create pull request from `feature/*` branch to `master`, and approve the request after it.
* Check your CI/CD pipeline (must be triggered after accepting the pull request).
* Check if your pipeline has succeeded.

<img width="550" alt="docker-cicd" src="https://user-images.githubusercontent.com/83014719/141645085-6063daa6-8e25-46d0-96d8-46ecda3fa2de.png">


