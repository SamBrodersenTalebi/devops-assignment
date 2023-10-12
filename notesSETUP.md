# How to run

## Overview

This is a Go-based project designed to run as a microservice. It is containerized using Docker and orchestrated using Kubernetes (minikube).

## Prerequisites

- Go (for local development)
- Docker
- Minikube
- Brew

## Setup

### Local Development

1. Clone this repository:

   ```bash
   git clone [repo_url]
   ```

2. Navigate to the project directory:

   ```bash
   cd devops-assignment
   ```

3. Install Go dependencies:

   ```bash
   go mod download
   ```

4. Run the application:

   ```bash
   go run main.go
   ```

### Docker Build / Run

1. Build the Docker image:

   ```bash
   docker build -t goapp:version2 .
   ```

2. Run the Docker container:

   ```bash
   docker run -p 8080:8080 goapp:version2
   ```

### Kubernetes Deployment with Minikube

1. Start Minikube:

   ```bash
   minikube start
   ```

2. Set up Minikube's local Docker daemon:

   ```bash
   eval $(minikube -p minikube docker-env)
   ```

3. Build image:

   ```bash
   docker build -t goapp:version2 .
   ```

4. Enable the ingress addon:

   ```bash
   minikube addons enable ingress
   ```

5. Deploy the application:

   ```bash
   kubectl apply -f configmap.yaml
   kubectl apply -f secret.yaml
   kubectl apply -f redis-volume.yaml
   kubectl apply -f deployment.yaml
   kubectl apply -f service.yaml
   kubectl apply -f ingress.yaml
   ```

6. Get the Minikube IP:

   ```bash
   minikube ip
   ```

7. Access the application at `http://<minikube_ip>`