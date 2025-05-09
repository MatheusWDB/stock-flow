FROM ubuntu:latest AS build

RUN apt-get update
RUN apt-get install openjdk-21-jdk -y
ENV JWT_SECRET="OPFMABHHSKFT"
COPY . .

RUN apt-get install maven -y
RUN mvn clean install -Dspring.profiles.active=${APP_PROFILE} -Djwt.secret=${JWT_SECRET}

FROM openjdk:21-jdk-slim

EXPOSE 8080

COPY --from=build /target/stock_flow-0.0.1-SNAPSHOT.jar app.jar

ENTRYPOINT [ "java", "-jar", "app.jar" ]
