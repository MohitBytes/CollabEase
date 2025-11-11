# ======================
# Stage 1 — Build WAR file
# ======================
FROM maven:3.9.9-eclipse-temurin-17 AS build
WORKDIR /app

# Copy pom.xml and source
COPY pom.xml .
COPY src ./src

# Build the WAR file (skip tests)
RUN mvn clean package -DskipTests

# ======================
# Stage 2 — Run on Tomcat
# ======================
FROM eclipse-temurin:17-jdk-jammy

# Install Tomcat
RUN apt-get update && apt-get install -y wget unzip \
    && wget https://downloads.apache.org/tomcat/tomcat-10/v10.1.31/bin/apache-tomcat-10.1.31.zip -O /tmp/tomcat.zip \
    && unzip /tmp/tomcat.zip -d /opt \
    && mv /opt/apache-tomcat-10.1.31 /opt/tomcat \
    && rm /tmp/tomcat.zip

# Copy the built WAR file from the previous stage
COPY --from=build /app/target/CollabEase.war /opt/tomcat/webapps/

EXPOSE 8080
CMD ["/opt/tomcat/bin/catalina.sh", "run"]