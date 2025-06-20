
# Step 1: Build with JDK
FROM eclipse-temurin:21-jdk-jammy as builder
WORKDIR /app
COPY spring/build/libs/spring-0.0.1-SNAPSHOT.jar app.jar

# Step 2: Run with JRE only
FROM eclipse-temurin:21-jre-jammy
WORKDIR /app
COPY --from=builder /app/app.jar app.jar
ENTRYPOINT ["java", "-jar", "app.jar"]
