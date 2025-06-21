---

## 📄 `k8s-manifests/README.md`

```md
# Kubernetes Manifests

Amazon EKS 위에 Spring Boot 애플리케이션을 배포하기 위한 매니페스트 파일 모음입니다.

# for ingress controller
eksctl create iamserviceaccount \
  --name aws-load-balancer-controller \
  --namespace kube-system \
  --cluster labs-eks-cluster \
  --role-name AmazonEKSLoadBalancerControllerRole \
  --attach-policy-arn arn:aws:iam::<ACCOUNT_ID>:policy/AWSLoadBalancerControllerIAMPolicy \
  --approve \
  --override-existing-serviceaccounts \
  --profile kasa-playground

## 배포 방법

```bash

kubectl apply -f deployment.yaml
kubectl apply -f service.yaml
kubectl apply -f ingress.yaml
