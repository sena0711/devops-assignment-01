# DevOps Assignment – EKS Infrastructure & Deployment

이 프로젝트는 Terraform, Kubernetes, GitHub Actions, Docker를 기반으로 AWS EKS 환경에 Spring Boot 애플리케이션을 배포하는 DevOps 과제입니다.

## 주요 구성 요소

- **Terraform**: VPC, Subnet, EKS 클러스터 구성
- **Kubernetes**: Spring Boot 앱 배포를 위한 매니페스트
- **Docker**: Spring Boot 애플리케이션 컨테이너화
- **GitHub Actions**: IAM User 없이 OIDC를 통한 AWS 배포 자동화

## 디렉토리 구조

```bash
spoonlabs-devops-assignment/
│
├── README.md              # 프로젝트 개요 및 배포 설명
│
├── terraform/             # AWS 인프라 생성 (Terraform 코드)
│
├── k8s-manifests/         # 쿠버네티스 배포 매니페스트
│
├── docker/                # Spring Boot Docker 빌드 소스
│
└── github-actions/        # Github Actions 파이프라인 정의

```
## 🌐 Network Architecture
- Public Subnets:
  - For exposing ALB to the internet
  - Connected to Internet Gateway (IGW)
- Private Subnets:
  - For EKS nodes and workloads (e.g., Spring Boot app)
  - Outbound traffic via NAT Gateway (1 per AZ)


            +-------------+
            |   Internet  |
            +------+------+
                   |
            +------+------+
            |    ALB      |  <- Public Subnets
            +------+------+
                   |
          +--------+--------+
          |     EKS Cluster  |  <- Private Subnets
          +--------+--------+
                   |
          +--------+--------+
          | Spring Boot Pods |
          +------------------+



## 🚀 Spring Boot App Deployment
- Built using Gradle (`./gradlew bootJar`)
- Docker image pushed to private ECR repo:
  ```bash
  docker build -t spring-hello .
  docker tag spring-hello:latest <account>.dkr.ecr.ap-northeast-2.amazonaws.com/spring-hello:latest
  docker push <account>.dkr.ecr.ap-northeast-2.amazonaws.com/spring-hello:latest


  Kubernetes manifests use node affinity to schedule on private subnets:

yaml
Copy
Edit
affinity:
  nodeAffinity:
    requiredDuringSchedulingIgnoredDuringExecution:
      nodeSelectorTerms:
      - matchExpressions:
        - key: topology.kubernetes.io/zone
          operator: In
          values:
          - ap-northeast-2a
          - ap-northeast-2c


          Terraform Modules Used
terraform-aws-modules/vpc/aws

terraform-aws-modules/eks/aws

These modules abstract away low-level resources, making it easy to configure production-grade infrastructure.

Access Control (OIDC-Based)
Terraform uses OIDC Federated Roles from Terraform Cloud

IAM Role mapped to system:masters in aws-auth configMap

EKS kubeconfig obtained using:


aws eks update-kubeconfig \
  --region ap-northeast-2 \
  --name labs-eks-cluster \
  --role-arn arn:aws:iam::<account>:role/allow-full-access
Then access granted to EKS:


kubectl edit configmap aws-auth -n kube-system


Final Checklist
 VPC with private/public subnets + NAT Gateway

 EKS with managed node groups in private subnets

 ALB in public subnet routing to app via Ingress

 Image built on Windows and pushed to ECR

 Terraform uses OIDC-based role, not static credentials

Screenshots & Diagrams
See images/ directory for:

OIDC role trust settings

Terraform Cloud Role setup

Network diagram

