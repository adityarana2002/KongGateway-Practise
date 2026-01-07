FROM eclipse-temurin:17-jdk-jammy

WORKDIR /app

COPY mvnw .
COPY mvnw.cmd .
COPY .mvn .mvn
COPY pom.xml .

RUN chmod +x mvnw

RUN ./mvnw dependency:go-offline

COPY src src

# Build the app
RUN ./mvnw clean package -DskipTests

# Rename jar to a fixed name
RUN cp target/*.jar app.jar

# Run the app
CMD ["java", "-jar", "app.jar"]
