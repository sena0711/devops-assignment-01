
---
## `docker/README.md`

```md
# Docker – Spring Boot Containerization

Spring Boot 애플리케이션을 Docker로 빌드하고 배포하기 위한 구성입니다.

##  구조

docker/
├── Dockerfile
└── spring/
    ├── build.gradle
    ├── settings.gradle
    ├── src/
    └── build/libs/spring-0.0.1-SNAPSHOT.jar (Gradle 빌드 후 생성됨)

## Requirements

- Java 17+
- Gradle
- Docker


## Make springboot APP

local test
.\gradlew.bat clean build (window )
./gradlew clean build (mac)
./gradlew bootRun
curl -v http://localhost:8080/

1. Spring Boot JAR 빌드

./gradlew clean bootJar

빌드 결과:
build/libs/your-app-name-0.0.1-SNAPSHOT.jar


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

```bash
aws ecr get-login-password --region ap-northeast-2 --profile kasa-playground | docker login --username AWS --password-stdin 207458591579.dkr.ecr.ap-northeast-2.amazonaws.com

docker tag my-spring-app:latest 207458591579.dkr.ecr.ap-northeast-2.amazonaws.com/my-spring-app:latest

docker push 207458591579.dkr.ecr.ap-northeast-2.amazonaws.com/my-spring-app:latest
```
