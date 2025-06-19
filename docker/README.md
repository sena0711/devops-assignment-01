
---

## 📄 `docker/README.md`

```md
# Docker – Spring Boot Containerization

Spring Boot 애플리케이션을 Docker로 빌드하고 배포하기 위한 구성입니다.

## Dockerfile

- JDK 기반 이미지 사용
- `application.jar` 을 복사하여 ENTRYPOINT로 실행
- 멀티스테이지 빌드 구조 가능

## 빌드 예시

```bash
docker build -t my-springboot-app .
```
## ECR 업로드

aws ecr get-login-password | docker login ...
docker tag my-springboot-app:latest [ECR_URI]:latest
docker push [ECR_URI]:latest