FROM maven:3.9.2-eclipse-temurin-17-alpine@sha256:4d9daa0d5471f52a318df5c4aa9d3ab6d5ade68bb5421a4844090cf5b140fbb2 AS builder

RUN mkdir /app

WORKDIR /app

COPY ./src ./src
COPY ./pom.xml ./pom.xml

RUN mvn clean package



FROM eclipse-temurin:17-jre-alpine@sha256:dd8238c151293ae6a7c22898ef2f0df2af8a05786aef73ccd3248e73765969ed

ENV APP_NAME=capstone \
    APP_VERSION=0.0.1-SNAPSHOT \
    SPRING_SERVER_PORT=8080

EXPOSE ${SPRING_SERVER_PORT}

RUN mkdir /app &&  \
    addgroup javauser &&  \
    adduser --disabled-password --shell /usr/sbin/nologin --ingroup javauser javauser && \
    chown -R javauser:javauser /app

USER javauser

WORKDIR /app

COPY --from=builder /app/target/${APP_NAME}-${APP_VERSION}.jar /app/${APP_NAME}-${APP_VERSION}.jar

ENTRYPOINT ["sh", "-c", "java -jar ${APP_NAME}-${APP_VERSION}.jar"]