FROM openjdk
COPY ./target/spring-boot-helloworld-1.0.0-SNAPSHOT.jar /spring-boot-helloworld-1.0.0-SNAPSHOT.jar
ADD ./app.sh /app.sh
RUN chmod a+x /app.sh
CMD /app.sh ; sleep infinity
