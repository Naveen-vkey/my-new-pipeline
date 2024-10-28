FROM azul/zulu-openjdk:17
RUN mkdir -p /root/logs /root/additional-files/vk-registry
COPY run.sh application.properties jarfiles/registry.jar /root/
RUN chmod 755 /root/run.sh && chmod -R 755 /root/logs
WORKDIR /root
ENTRYPOINT ["/root/run.sh", "start", "vk-registry"]
