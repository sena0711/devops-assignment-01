---

## 📄 `k8s-manifests/README.md`

```md
# Kubernetes Manifests

Amazon EKS 위에 Spring Boot 애플리케이션을 배포하기 위한 매니페스트 파일 모음입니다.


## 배포 방법

kubectl apply -f https://github.com/aws/eks-charts/raw/master/stable/aws-load-balancer-controller/crds/crds.yaml

```bash
kubectl apply -f ./ingress-class/alb-ingressclassparams.yaml
kubectl apply -f ./ingress-class/alb-ingressclass.yaml


kubectl apply -f deployment.yaml
kubectl apply -f service.yaml
kubectl apply -f public-ingress.yaml
