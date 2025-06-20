
## 📄 `terraform/README.md`

```md
# Terraform – EKS Infrastructure

Terraform을 사용하여 AWS에 다음 리소스를 구성합니다:

- VPC 및 서브넷 (2개의 AZ에 Public/Private Subnet 구성)
- Internet Gateway, NAT Gateway, Route Table
- EKS 클러스터 및 노드 그룹

## 실행 순서

1. Terraform Cloud에서 workspace 및 backend 설정 (`backend.tf`)
2. 환경 변수 설정 (Terraform Cloud 또는 로컬 `.tfvars`)
3. 초기화 및 적용

```bash
terraform init
terraform plan
terraform apply
```

terraform , aws oidc 를 사용해서 진행하였다면 console 에서 본인이 사용하는 롤 또는 아이디를 등록후 
kubectl edit configmap aws-auth -n kube-system -o yaml 에서 본인 아이디를 등록해야 
kubeconfig 가  가능해진다. 

aws eks --region ap-northeast-2 update-kubeconfig --name labs-eks-cluster --profile kube