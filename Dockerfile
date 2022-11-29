FROM maven as build
WORKDIR /app
COPY . .
RUN mvn clean install

FROM openjdk:11.0
WORKDIR /app
COPY --from=build /app/target/devops-integartion.jar .
CMD ["java","-jar","devops-integartion.jar"]