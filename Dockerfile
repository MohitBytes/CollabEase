# Stage 1: Build the WAR file using Maven
FROM maven:3.9.9-eclipse-temurin-17 AS build
WORKDIR /app

# Copy Maven config and source
COPY pom.xml .
COPY src ./src

# Build the WAR (skip tests for speed)
RUN mvn clean package -DskipTests

# Stage 2: Run the built WAR using Tomcat (preinstalled)
FROM tomcat:10.1-jdk17-temurin

# Remove the default ROOT webapp
RUN rm -rf /usr/local/tomcat/webapps/ROOT

# Copy WAR file from build stage to Tomcat webapps
COPY --from=build /app/target/CollabEase.war /usr/local/tomcat/webapps/ROOT.war

# Expose port 8080 for Render
EXPOSE 8080

# Start Tomcat
CMD ["catalina.sh", "run"]
