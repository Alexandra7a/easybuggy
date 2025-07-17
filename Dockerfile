# Use a base image with Java 17 (or the required version) and a minimal footprint
FROM eclipse-temurin:17-jre-alpine

# Set the working directory inside the container
WORKDIR /app

# Copy only the pom.xml file first to leverage Docker caching
COPY pom.xml .

# Download dependencies without building the application
RUN mvn dependency:go-offline -B

# Copy the source code into the container
COPY src ./src

# Build the application using Maven
RUN mvn clean install -DskipTests # Skip tests during image build for faster builds, run them in CI/CD

# Expose the port your application runs on (usually 8080)
EXPOSE 8080

# Define the command to run the application when the container starts.  Adjust if necessary based on your JAR name.
CMD ["java", "-jar", "target/*.jar"]

# Optional: Create a non-root user for security (adjust as needed)
# RUN addgroup -S easybuggy && adduser -S easybuggy -G easybuggy
# USER easybuggy