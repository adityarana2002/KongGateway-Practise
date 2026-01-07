FROM eclipse-temurin:17-jdk-jammy

WORKDIR /app

# Copy maven wrapper
COPY mvnw .
COPY mvnw.cmd .
COPY .mvn .mvn
COPY pom.xml .

# ✅ FIX: give execute permission to mvnw
RUN chmod +x mvnw

# Download dependencies
RUN ./mvnw dependency:go-offline

# Copy source
COPY src src

# Build application
RUN ./mvnw clean package -DskipTests

# Run application
CMD ["java", "-jar", "target/*.jar"]
