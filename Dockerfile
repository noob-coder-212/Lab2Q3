
# Use an official Maven image to build your project
FROM maven:3.8.4-jdk-11 AS build

# Set the working directory
WORKDIR /app

# Copy the Maven project's pom.xml and source code to the container
COPY pom.xml .
COPY src ./src

# Build the Maven project and package it as a WAR file
RUN mvn clean package -DskipTests

# Use an official Tomcat image as the base image
FROM tomcat:9.0

# Remove the default web application provided by Tomcat
RUN rm -rf /usr/local/tomcat/webapps/ROOT

# Copy the WAR file built by Maven to the Tomcat webapps directory
COPY --from=build /app/target/simple-maven-web.war /usr/local/tomcat/webapps/ROOT.war

# Start Tomcat
CMD ["catalina.sh", "run"]
