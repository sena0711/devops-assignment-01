# DevOps Assignment – EKS Infrastructure & Deployment

이 프로젝트는 Terraform, Kubernetes, GitHub Actions, Docker를 기반으로 AWS EKS 환경에 Spring Boot 애플리케이션을 배포하는 DevOps 과제입니다.

## 주요 구성 요소

- **Terraform**: VPC, Subnet, EKS 클러스터 구성
- **Kubernetes**: Spring Boot 앱 배포를 위한 매니페스트
- **Docker**: Spring Boot 애플리케이션 컨테이너화
- **GitHub Actions**: IAM User 없이 OIDC를 통한 AWS 배포 자동화

## 디렉토리 구조

```bash
devops-assignment/
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
│
└── images/                # 적용 이미지 스크린샷 모음

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


## 🌐 서브넷 구성

### Public Subnets
- ALB (Application Load Balancer) 노출
- IGW (Internet Gateway) 연결

### Private Subnets
- EKS 노드 및 Spring Boot 애플리케이션 배포
- NAT Gateway를 통한 외부 접근 허용

---

## Terraform Modules Used

- [`terraform-aws-modules/vpc/aws`](https://github.com/terraform-aws-modules/terraform-aws-vpc)  
  → VPC, Subnet, NAT Gateway, Route Table 등 네트워크 리소스 자동 구성

- [`terraform-aws-modules/eks/aws`](https://github.com/terraform-aws-modules/terraform-aws-eks)  
  → EKS 클러스터, Node Group, IAM, 애드온 구성 자동화

- [`terraform-aws-modules/iam/aws`](https://github.com/terraform-aws-modules/terraform-aws-iam)  
  → OIDC 연동용 IAM Role, Policy, Role Attachment 등 관리

## 🛠️ Terraform으로 생성된 주요 리소스

Terraform Cloud를 통해 총 **64개의 리소스가 생성**되었으며, EKS 클러스터와 그에 필요한 네트워크, 보안, IAM 리소스를 포함합니다.

### ✅ EKS 관련 리소스

- EKS 클러스터 및 관리형 노드 그룹
  - `aws_eks_cluster`
  - `aws_eks_node_group`
- EKS 애드온 (Add-ons)
  - `vpc-cni`, `kube-proxy`, `coredns`
- OIDC provider 설정
  - `aws_iam_openid_connect_provider`
- ALB Ingress Controller 연동 IAM Role
  - `aws_iam_role`
  - `aws_iam_policy`
  - `aws_iam_role_policy_attachment`
- Cluster 접근 제어
  - `aws_auth` ConfigMap 설정 (system:masters)
  - `aws_eks_access_entry`
  - `aws_eks_access_policy_association`

### 📦 IAM 관련 리소스

- Terraform Cloud용 OIDC 기반 IAM Role
- ECR, CloudWatch, ALB Ingress 관련 정책들:
  - `AmazonEC2ContainerRegistryReadOnly`
  - `AmazonEKS_CNI_Policy`
  - `AmazonEKSWorkerNodePolicy`
  - `AmazonEKSClusterPolicy`
  - `AmazonEKSVPCResourceController`

### 🔐 보안 그룹 (Security Groups)

- EKS 클러스터 및 노드 그룹용 SG
- 다양한 Ingress 규칙 생성 (webhook, alb, console, nodes 등)

### 🌐 네트워크 (VPC 및 Subnet)

- VPC 생성
  - CIDR 블록, DNS 지원
- 퍼블릭/프라이빗 서브넷 (AZ별)
  - `subnet.public[0-2]`, `subnet.private[0-2]`
- NAT 게이트웨이 및 인터넷 게이트웨이
- 라우팅 테이블 및 서브넷 연관
  - `route_table_association.public`, `route_table_association.private`

---

## Spring Boot App Dockerization

1. **Gradle로 JAR 파일 빌드:**

   ```bash
   ./gradlew bootJar
   ```

2. **Docker 이미지 빌드 및 ECR 푸시**

```bash
docker build -t spring-hello .
docker tag spring-hello:latest <account>.dkr.ecr.ap-northeast-2.amazonaws.com/spring-hello:latest
docker push <account>.dkr.ecr.ap-northeast-2.amazonaws.com/spring-hello:latest
```
## ☸️ Kubernetes 배포 전략

- 특정 가용 영역(AZ)에 노드가 스케줄되도록 Affinity 설정:

```yaml
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
```

## 🔐 Access Control (OIDC 기반)

- Terraform Cloud에서 **OIDC Federated Role** 사용


### EKS 접근 명령어

```bash
aws eks update-kubeconfig \
  --region ap-northeast-2 \
  --name labs-eks-cluster 
```
```bash
kubectl edit configmap aws-auth -n kube-system
```

### EKS 배포 명령어 
```bash
kubectl apply -f ./ingress-class/alb-ingressclassparams.yaml
kubectl apply -f ./ingress-class/alb-ingressclass.yaml
kubectl apply -f deployment.yaml
kubectl apply -f service.yaml
kubectl apply -f public-ingress.yaml
```


