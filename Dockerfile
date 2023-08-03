#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Builder Images
# -----------------------------------------------------------------------------
FROM maven:3.9.2 as spring-app
COPY src /home/app/src
COPY pom.xml /home/app/pom.xml
RUN mvn -f /home/app/pom.xml clean package

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Application Image
# -----------------------------------------------------------------------------
FROM amazoncorretto:17

ENV APP_PATH /app
COPY --from=spring-app /home/app/target/spring-boot-*.jar ${APP_PATH}/libs/

CMD java -jar ${APP_PATH}/libs/spring-boot-*.jar
