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
