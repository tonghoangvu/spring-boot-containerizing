FROM maven:3.9.9-eclipse-temurin-21-alpine AS builder
WORKDIR /tmp
COPY pom.xml pom.xml
RUN mvn dependency:go-offline
COPY src src
RUN mvn package

FROM eclipse-temurin:21-jre-alpine
WORKDIR /opt/app
COPY --from=builder /tmp/target/*.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]
