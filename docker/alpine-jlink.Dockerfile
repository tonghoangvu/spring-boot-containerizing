FROM eclipse-temurin:21-jdk-alpine AS builder
WORKDIR /tmp
RUN jlink --add-modules java.se --strip-debug --no-man-pages --no-header-files --compress=2 --output jre

FROM alpine:3.21.2
ENV JAVA_HOME=/opt/java/openjdk
ENV PATH=$JAVA_HOME/bin:$PATH
COPY --from=builder /tmp/jre $JAVA_HOME
WORKDIR /opt/app
COPY target/*.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]
