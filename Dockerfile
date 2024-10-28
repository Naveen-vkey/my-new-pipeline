FROM azul/zulu-openjdk:17
EXPOSE 8762
ADD jarfiles/registry.jar /registry.jar
ENTRYPOINT ["java", "-jar", "/registry.jar"]
