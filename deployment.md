# GKE Deployment & Performance Profiling

This guide covers the steps for deploying the DeathStarBench Social Network to Google Kubernetes Engine (GKE) and performing performance profiling. It includes steps from setting up the project in GKE to deploying the application, simulating workloads, and analyzing performance.

## Table of Contents
1. [Prerequisites](#prerequisites)
2. [Setting up GKE Cluster](#setting-up-gke-cluster)
3. [Deploying the Application Using Helm](#deploying-the-application-using-helm)
4. [Profiling CPU, Memory, and Latency](#profiling-cpu-memory-and-latency)
5. [Scaling and Load Balancing](#scaling-and-load-balancing)
6. [Troubleshooting](#troubleshooting)

## Prerequisites

1. **Google Cloud Project**
   - Set up a Google Cloud Project and enable Kubernetes Engine.
   - Ensure `gcloud` CLI is installed and authenticated with your Google Cloud account.

2. **Google Kubernetes Engine (GKE)**
   - Install `kubectl` and `gcloud` CLI tools.
   - Enable Kubernetes Engine API in your project.
   - Set your project ID and configure the `gcloud` CLI.

3. **Helm**
   - Install Helm for managing Kubernetes applications.

## Setting up GKE Cluster

1. Create a Kubernetes cluster in GKE:
    ```bash
    gcloud container clusters create deathstar-cluster \
      --zone=asia-south1-a \
      --cluster-version=latest \
      --num-nodes=1
    ```

2. Configure `kubectl` to use the new cluster:
    ```bash
    gcloud container clusters get-credentials deathstar-cluster --zone asia-south1-a
    ```

3. Verify the cluster status:
    ```bash
    kubectl get nodes
    ```

## Deploying the Application Using Helm

1. Clone the DeathStarBench repository and navigate to the `socialNetwork` folder:
    ```bash
    git clone https://github.com/DeathStarBench/DeathStarBench.git
    cd DeathStarBench/socialNetwork/helm-chart/socialnetwork
    ```

2. Create a namespace for the application:
    ```bash
    kubectl create namespace deathstarbench
    ```

3. Install the application using Helm:
    ```bash
    helm install social-network . -n deathstarbench --create-namespace
    ```

4. Check the status of the pods:
    ```bash
    kubectl get pods -n deathstarbench
    ```

## Profiling CPU, Memory, and Latency

To profile the application's performance:

1. **Simulate Workload:**
   - Write a script to simulate a read and write workload for the social network.

2. **Use Prometheus and Grafana:**
   - Install Prometheus for monitoring:
     ```bash
     helm install prometheus stable/prometheus --namespace deathstarbench
     ```

   - Set up Grafana for visualizing performance metrics.
   - Configure Prometheus as a data source in Grafana.

3. **Run the Workload and Monitor:**
   - Start the workload script and monitor the CPU, memory usage, and latency using Grafana.

## Scaling and Load Balancing

To scale the deployment and improve load balancing:

1. **Horizontal Pod Autoscaling:**
   - Configure Horizontal Pod Autoscaler (HPA) to automatically scale the number of replicas based on CPU or memory usage.

2. **Cluster Autoscaler:**
   - Enable Google Cloud's Cluster Autoscaler to scale the cluster nodes based on workload demands.

3. **Test Different Configurations:**
   - Test different configurations by adjusting the number of nodes or using multiple node pools.

## Troubleshooting

If you encounter issues such as pod scheduling errors due to insufficient resources, consider the following:

- Check the current node resources:
  ```bash
  kubectl describe node <node-name>
