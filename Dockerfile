FROM azul/zulu-openjdk:17

RUN echo Build docker image
RUN mkdir -p /root/logs
RUN mkdir -p /root/additional-files/vk-registry

# Copy the run.sh script and application.properties
COPY run.sh /root/
COPY application.properties /root/

# Copy the specific JAR file for this service
COPY jarfiles/registry.jar /root/

# Set file permissions
RUN chmod 755 /root/run.sh
RUN chmod -R 755 /root/logs

# Set the working directory
WORKDIR /root

# Define the entrypoint to start the service
ENTRYPOINT ["/root/run.sh", "start", "vk-registry"]
