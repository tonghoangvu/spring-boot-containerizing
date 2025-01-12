FROM eclipse-temurin:21-jre-alpine AS builder
WORKDIR /tmp
COPY target/*.jar app.jar
RUN java -Djarmode=tools -jar app.jar extract --layers --destination app

FROM eclipse-temurin:21-jre-alpine
WORKDIR /opt/app
COPY --from=builder /tmp/app/dependencies .
COPY --from=builder /tmp/app/spring-boot-loader .
COPY --from=builder /tmp/app/snapshot-dependencies .
COPY --from=builder /tmp/app/application .
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]
