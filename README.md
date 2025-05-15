# 📦 Bookinfo Deployment with Harbor Private Registry and SSL on EC2

This project demonstrates deploying the [Bookinfo microservices application](https://istio.io/latest/docs/examples/bookinfo/) using Docker images hosted on a **private Harbor registry** deployed on an **AWS EC2 instance** with **SSL configured via Route 53**. The Kubernetes manifests are configured to pull images securely using `imagePullSecrets`.

## 📚 Table of Contents

- [Architecture Overview](#architecture-overview)
- [✅ Pre-requisites](#pre-requisites)
- [1. Deploy Harbor on EC2](#1-deploy-harbor-on-ec2)
- [2. Setup SSL with Route 53](#2-setup-ssl-with-route-53)
- [3. Push Docker Images to Harbor](#3-push-docker-images-to-harbor)
- [4. Deploy Bookinfo on Kubernetes](#4-deploy-bookinfo-on-kubernetes)
- [5. Accessing the Application](#5-accessing-the-application)
- [Resources](#resources)

---

## 🏗 Architecture Overview

```bash
Internet ──► Route 53 (DNS) ──► EC2 (Harbor + SSL)
                                 │
                                 ▼
                           Private Registry
                                 │
                                 ▼
                      Kubernetes Cluster
                       ├── details
                       ├── ratings
                       ├── reviews (v1, v2, v3)
                       └── productpage
```

---

## ✅ Pre-requisites
- AWS account with access to EC2 and Route 53

- A registered domain name in Route 53

- Kubernetes cluster (e.g., EKS, k3s, Minikube)

- Docker CLI

- kubectl configured for your cluster

---

