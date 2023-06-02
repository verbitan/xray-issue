#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Builder Images
# -----------------------------------------------------------------------------
FROM bash:5 as xray-agent
ADD https://github.com/aws/aws-xray-java-agent/releases/download/v2.9.1/xray-agent.zip /xray-agent.zip
RUN unzip /xray-agent.zip


FROM maven:3.9.2 as spring-app
COPY src /home/app/src
COPY pom.xml /home/app/pom.xml
RUN mvn -f /home/app/pom.xml clean package

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Application Image
# -----------------------------------------------------------------------------
FROM amazoncorretto:17

ENV APP_PATH /app
COPY --from=xray-agent /disco ${APP_PATH}/libs/disco
COPY --from=spring-app /home/app/target/spring-boot-*.jar ${APP_PATH}/libs/

CMD java -javaagent:${APP_PATH}/libs/disco/disco-java-agent.jar=pluginPath=${APP_PATH}/libs/disco/disco-plugins \
         -jar ${APP_PATH}/libs/spring-boot-*.jar
