# Build stage
FROM maven:3.8.8-eclipse-temurin-21-alpine AS build
WORKDIR /app
COPY pom.xml .
COPY src ./src
RUN mvn clean package -DskipTests

# Run stage
FROM tomcat:10.1.24-jdk21
WORKDIR /usr/local/tomcat/webapps/
COPY --from=build /app/target/*.war ./ROOT.war
EXPOSE 8080
CMD ["catalina.sh", "run"]