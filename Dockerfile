# ======================
# Stage 1 — Build WAR file
# ======================
FROM maven:3.9.9-eclipse-temurin-17 AS build
WORKDIR /app

# Copy pom.xml and source
COPY pom.xml .
COPY src ./src

# Build the WAR file (skip tests for speed)
RUN mvn clean package -DskipTests

# ======================
# Stage 2 — Run on Tomcat
# ======================
FROM eclipse-temurin:17-jdk-jammy

# Install Tomcat
RUN apt-get update && apt-get install -y wget unzip \
    && wget https://dlcdn.apache.org/tomcat/tomcat-10/v10.1.30/bin/apache-tomcat-10.1.30.zip -O /tmp/tomcat.zip \
    && unzip /tmp/tomcat.zip -d /opt \
    && mv /opt/apache-tomcat-10.1.30 /opt/tomcat \
    && rm /tmp/tomcat.zip

# Copy WAR from build stage
COPY --from=build /app/target/CollabEase.war /opt/tomcat/webapps/

EXPOSE 8080
CMD ["/opt/tomcat/bin/catalina.sh", "run"]
