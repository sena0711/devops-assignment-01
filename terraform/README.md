
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
3. 초기화 및 적용.

```bash
terraform init
terraform plan
terraform apply
```

OIDC Role을 통해 Terraform으로 EKS 클러스터 생성
이 때 사용된 IAM Role은 EKS 클러스터에는 자동으로 권한이 부여되지 않음

Console에서 접근할 사용자 또는 Role 확인
EKS → Configuration → Access 탭에서 현재 연결된 IAM 사용자/역할 확인

terraform이 사용하는 assume-role ARN을 복사
예: arn:aws:iam::<ACCOUNT_ID>:role/<your-terraform-role>

kubectl edit configmap aws-auth -n kube-system

aws eks --region ap-northeast-2 update-kubeconfig --name labs-eks-cluster --profile kube

after applyin kube auth you will be adding something like below. 

'''bash
    - groups:
      - system:bootstrappers
      - system:nodes
      rolearn: arn:aws:iam::207458591579:role/default-eks-node-group-20250621064845411200000002
      username: system:node:{{EC2PrivateDNSName}}
    - groups:
      - system:bootstrappers
      - system:masters
      rolearn: arn:aws:iam::207458591579:role/allow-terraform-test
      username: terraform
    - groups:
      - system:bootstrappers
      - system:masters
      rolearn: arn:aws:iam::207458591579:role/allow-full-access
      username: admin
'''

그래도 동작하지 않는다면 콘솔 access 에서 

AmazonEKSClusterAdminPolicy 을 추가하여 동작한다. 