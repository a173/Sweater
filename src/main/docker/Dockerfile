FROM adoptopenjdk:11-jre-hotspot
ARG JAR_FILE=*.jar
COPY ${JAR_FILE} application.jar
RUN mkdir uploads
RUN chmod 777 uploads
ENTRYPOINT ["java", "-jar", "application.jar"]