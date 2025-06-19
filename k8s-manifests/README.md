---

## 📄 `k8s-manifests/README.md`

```md
# Kubernetes Manifests

Amazon EKS 위에 Spring Boot 애플리케이션을 배포하기 위한 매니페스트 파일 모음입니다.


## 배포 방법

```bash
kubectl apply -f namespace.yaml
kubectl apply -f deployment.yaml
kubectl apply -f service.yaml
kubectl apply -f ingress.yaml