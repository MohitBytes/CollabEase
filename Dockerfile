# Use Tomcat 9 with OpenJDK 17 for runtime
FROM tomcat:9-jdk17-openjdk-slim

# Remove default ROOT application
RUN rm -rf /usr/local/tomcat/webapps/ROOT

# Copy the pre-built WAR file
COPY target/CollabEase.war /usr/local/tomcat/webapps/ROOT.war

# Create logs directory
RUN mkdir -p /usr/local/tomcat/logs

# Expose port 8080
EXPOSE 8080

# Start Tomcat
CMD ["catalina.sh", "run"]