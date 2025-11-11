# Step 1: Use an OpenJDK image
FROM eclipse-temurin:17-jdk-jammy

# Step 2: Install Tomcat
RUN apt-get update && apt-get install -y wget unzip \
    && wget https://dlcdn.apache.org/tomcat/tomcat-10/v10.1.30/bin/apache-tomcat-10.1.30.zip -O /tmp/tomcat.zip \
    && unzip /tmp/tomcat.zip -d /opt \
    && mv /opt/apache-tomcat-10.1.30 /opt/tomcat \
    && rm /tmp/tomcat.zip

# Step 3: Copy WAR file
COPY target/CollabEase.war /opt/tomcat/webapps/

# Step 4: Expose port
EXPOSE 8080

# Step 5: Start Tomcat
CMD ["/opt/tomcat/bin/catalina.sh", "run"]