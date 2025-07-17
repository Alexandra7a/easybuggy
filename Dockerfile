# Use a base image with Java 17 pre-installed
FROM eclipse-temurin:17-jre-jammy

# Set the working directory inside the container
WORKDIR /app

# Copy the pom.xml file to download dependencies in a separate layer
COPY pom.xml .

# Download Maven dependencies, caching them for faster builds
RUN mvn dependency:go-offline

# Copy the source code into the container
COPY src ./src

# Build the application using Maven
RUN mvn clean compile package -DskipTests

# Expose port 8080 for the web application
EXPOSE 8080

# Define the command to run the application when the container starts
CMD ["java", "-jar", "target/*.war"]